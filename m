Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464615EE613
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 21:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiI1TyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 15:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiI1TyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 15:54:19 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8819E7FE60
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:54:17 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a14so15487815ljj.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=2ZLG2KC41uqqU7owxniwJkXOna9QouCniVvRwX+2hQE=;
        b=V9fbXz50h5ugIyicyu3iwlMmbCD/QKwWgp/1OHAGgHE6aJ6vtjAj8BQoJysQQtkZ6K
         bmprbpyk4ZnLN3Ab3DOSI966806GRir1vVsjOgJ2ybDziB/QeVuy6MGi/Pe2GbygGrKR
         Htzrjpa2UDVbujOQPbtOUjtHFPox34vdswgGe4bhSWEiwZWU+siEsyoh4/MEAmPMwoZO
         HFMD7g9rNylyJXNdwTwcUmpQtf/ohz5uo/fFnbOMCns0sC961+PzIoqa0uQzStKRVUWW
         EizXfdwMNH1+5A4mBSlMi8tscQVO1U695FdaHQLewSlJh7OeEVu/jaZi+ZNgNAQpcte9
         etsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2ZLG2KC41uqqU7owxniwJkXOna9QouCniVvRwX+2hQE=;
        b=IwTGaDXhspRVOUp0lV0I2KYRSR0YO9AR8s/mYyciiuxLVLvh5IVxHHkuwPzeN+HBiy
         kQcbghOrLaXcaSB2ZlSVrUNGfyRBpA+3DOyZfCgxPw7se4dxB2nAjABLsTc1AvLhjyYE
         AtTdeofXz2Ph+glDAWeXOBL2D0fvL1/4jBkKpujKKVv2bPl67STCH+UcbHofZW3hsbnQ
         VbRgcgUWTesXoK6tLbEUj02/qDQdgaZymYLOCMRe3Gz9lvgFUiUs04NLrP2x3BpDyVuT
         5F5/6E7Re6VZXCwt6QIo4mnxqDKrw6Zx+n3r+IEhMsuuSNgz+oMsmmiUnpK8CmSHs+Ni
         lfDQ==
X-Gm-Message-State: ACrzQf0AegehxRrAzo6Sqcde5LVFGbiQFGBIqVyZ/eb7j0Wf9+kenC1V
        QxAxQhTC5T18BeQaq6KdaFi3Dw==
X-Google-Smtp-Source: AMsMyM7IB+1z/6d4whb6N1kyhq69FGzIPwPKCyyD/rDeDY7HIua6rhFqmjg8lGgXr6a25l7MJUXDgg==
X-Received: by 2002:a2e:958a:0:b0:26a:a393:4480 with SMTP id w10-20020a2e958a000000b0026aa3934480mr12072300ljh.490.1664394855969;
        Wed, 28 Sep 2022 12:54:15 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id p11-20020ac246cb000000b00497ad9ae486sm563059lfo.62.2022.09.28.12.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 12:54:15 -0700 (PDT)
Message-ID: <70baf417-1c2c-932d-0b2b-048f3809d4ab@linaro.org>
Date:   Wed, 28 Sep 2022 22:54:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 13/13] phy: qcom-qmp-pcie: clean up clock lists
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220928152822.30687-1-johan+linaro@kernel.org>
 <20220928152822.30687-14-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220928152822.30687-14-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 18:28, Johan Hovold wrote:
> Keep the clock lists together and sorted by symbol name.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

