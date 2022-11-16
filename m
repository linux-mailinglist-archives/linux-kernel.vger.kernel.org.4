Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D4562CF2A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbiKPXzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbiKPXy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:54:57 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AE465843;
        Wed, 16 Nov 2022 15:54:57 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id l2so10294pld.13;
        Wed, 16 Nov 2022 15:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iprZAHSISVtQdP/2UgUsmrG9XIXOQqchZuDkoGWDWUc=;
        b=brwYqI6wHTmWy+VKox3XU2FzHp2hgzzO4rTedvhInstWZJdr/VwUinmLhWtWs/TOdD
         wgTLtTY5eylPqhX/3JVwB8NXSm0bZ++o5lG/tb0zFm1iYzLUvjMDT9tuHQjkNOPLcSbc
         IhfN7NYsp+M6pkoXcDvmBasAznNgP960Sy5HoFRMMMvn8D2QQF9aUv91y6nAlxG8+EEa
         iWqVza7fxfb5sOBfyy17sGOq0MFlT1zTSnHcIBz+HhgOqTN/R1A83/bLCqP4/JxUu+/b
         KijSGpoj+arpLfaJM0ux+tI++XY9gwwbf3VnS/Q81By1q9GYHqxqz7u6oY1/K0ZoNtar
         a8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iprZAHSISVtQdP/2UgUsmrG9XIXOQqchZuDkoGWDWUc=;
        b=yYANhfv6AwZ10z9LXBQwadg4AACxBPEbSu2j8QkR5+i078IOH80eAPSa0ReXPomo3c
         yUoPC/G67EMkuaxiJndMc6sU9WWqLV0LbyJf824dLJT8yJsUZ+c42pATe9d407gylH7D
         t2qkqsilNDNkh3+9PmLiqD9MqdKAuBp2K5i89K8XH81F0bfV2nQPpL5PIJ7KCLnOKs8C
         uiE9hbnUBIkb7oX4AcFabajuG1UE2hf64WzetnpqqFQ134W21LEcHDRq01j55qTMfw3q
         7+z+ljHjUPQg+sWj2Mxm4M7rXTGslcuvIYJ9KRNR5JTWdI+eSr8hWx92p0DlQ+Yp03/2
         TwiA==
X-Gm-Message-State: ANoB5pmLvgdgsfqIcWMk2BBFOT0PdCHFXT24Z5NSucSSk/sDy1m0YHQK
        nHt6cpbeFEOgA70H7SjAx+VTgynaU+Q=
X-Google-Smtp-Source: AA0mqf79tb/y9XkgGirBsiAMm8mZz7yUH24/aK2UpKD1h6N7L1FakxsexIUTYLkHGc3nByr7uLpYnw==
X-Received: by 2002:a17:903:2583:b0:179:ee39:e300 with SMTP id jb3-20020a170903258300b00179ee39e300mr223855plb.58.1668642896440;
        Wed, 16 Nov 2022 15:54:56 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:fb51:2ecd:7287:8649])
        by smtp.gmail.com with ESMTPSA id x13-20020a62860d000000b00562a526cd2esm11467886pfd.55.2022.11.16.15.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 15:54:55 -0800 (PST)
Date:   Wed, 16 Nov 2022 15:54:52 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, w.david0@protonmail.com,
        stephan@gerhold.net, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v6 2/2] Input: msg2638 - Add support for msg2138 key
 events
Message-ID: <Y3V4TIEW2qtcFLm8@google.com>
References: <20221116211622.2155747-1-vincent.knecht@mailoo.org>
 <20221116211622.2155747-3-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116211622.2155747-3-vincent.knecht@mailoo.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 10:16:17PM +0100, Vincent Knecht wrote:
> Some devices with msg2138 have back/menu/home keys.
> Add support for them.
> 
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>

Applied, thank you.

-- 
Dmitry
