Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897DD7055DA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjEPSTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjEPSTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:19:14 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6C6271B
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:19:10 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-644d9bf05b7so8503781b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684261150; x=1686853150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S2KXWalTdvuGRBWwyxeiECFs48vb0kc6jIG6BVZ17mo=;
        b=Z+oc/RnmkqCau1eig8XC59UFZDXTkKpJLVIle+4Fox0TpnKXHVaVyftTO51uf+LWTX
         IcxX+7w1jlQ3yRO8Q4hNA1rbsRiqf14wZo1H/OmgD0pGGRHlElIMPYPqO0hK9ONPzhL0
         U3caLl/jlIPZqNdr5fhCkQQMWIz7+cJDQYnY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684261150; x=1686853150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2KXWalTdvuGRBWwyxeiECFs48vb0kc6jIG6BVZ17mo=;
        b=GfJWv1f5Mx7VHYJHCHzDdyL6hkfUY57S20vbX0SUx2AIFDB3IF42afL3Yr52YhGmWh
         BjaG1cGcSnjEIJ7B8/wj/NfxjWwW1n9fcMDfK90Y2sR59V19wiWo3+RKJQJ7ZO4Yv6oY
         naM7NUAnIlBURa2EGtQkrQpxQa0SaeNdXfXxru+tfCSLlSqWWLeQ+Q3cZXiyGfuEPcWW
         N+pJGqGcvmHUUCHZAmdzJIn93GZlYAQjAxnhc4vm3mPAECY81+2VN3z3ksdFOvhMcr+L
         XRDqDEOwTg0QAQBpbqsj55rcRzfao/4Vyo4SzOvY/wycmk1aVyW/F0gvxSXmCJknZrlW
         oGKw==
X-Gm-Message-State: AC+VfDxGZ3fXFXrE8yv33XoMeDiQ4dadSb3oHZi+ScGGpEkBbh6LXGI5
        Apf0v9IBE9m4XuXvMNw2CGKx2g==
X-Google-Smtp-Source: ACHHUZ5JIQKxCPQ27BHIeg2iA39AMfvy4E6QWK0tSVz7aRpKK8uGONHyNmjFI2YOy2GrosvFVaFsWA==
X-Received: by 2002:a05:6a00:22d3:b0:64a:a432:f313 with SMTP id f19-20020a056a0022d300b0064aa432f313mr22510808pfj.31.1684261150336;
        Tue, 16 May 2023 11:19:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b0062607d604b2sm13768911pfo.53.2023.05.16.11.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 11:19:09 -0700 (PDT)
Date:   Tue, 16 May 2023 11:19:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jiawen Wu <jiawenwu@trustnetic.com>,
        Mengyuan Lou <mengyuanlou@net-swift.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: libwx: Replace zero-length array with
 flexible-array member
Message-ID: <202305161119.B6E9737124@keescook>
References: <ZGKGwtsobVZecWa4@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGKGwtsobVZecWa4@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 01:23:46PM -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays as fake flexible arrays are deprecated, and we are
> moving towards adopting C99 flexible-array members instead.
> 
> Transform zero-length array into flexible-array member in struct
> wx_q_vector.
> 
> Link: https://github.com/KSPP/linux/issues/21
> Link: https://github.com/KSPP/linux/issues/286
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
