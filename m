Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65514615E26
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiKBIpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKBIpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:45:46 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0ABB24F22
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 01:45:45 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c2so15903250plz.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 01:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TOClqmxlvPnNU/Xt17KTim859Uzye5tKFUlkimgaw9k=;
        b=J6StuQV7F+5TBvqyuzI6uExx4RNgyQYedibLywGw1li8yywvZP1A4V5QGspEfUArqN
         f3YQu2LQ67l6kUpnFTVDchgELu/PpziEW7Iyr6d3DPl0ZTZD8pDsJmfVJfQFEFo8nyKZ
         VJYAeMeVR8JLt5IYAPGvV2Y6LfjkGHaX13FFJT/oAmPY/koXSKpT1YxqOqXVXn63OSz5
         tw1eNHP94v1XAallkqaa3W/OQZ5SXsxEE6uWmnAXFhgB1LSWNq4TNe3wR6FeZLI70iIN
         omUgSrH7xROcuMLdm5A5481l9/1SyLsNx7p2rcE9QNDO+1gG01Xc2wmcq5RnIkusLyKb
         lMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOClqmxlvPnNU/Xt17KTim859Uzye5tKFUlkimgaw9k=;
        b=1JcZgZfVjpD0c+TF/imp2xl8lWIPiLlhVU720yQ/viwNnawb2fkI5u1ZbYuS4byxRl
         qiYT2IMrSNOZZJmt4pJfs8/oNISDc6UMM77NRNCBNlFVisUf9vIFbfgRGkzZW3JAEDqM
         mrpbzv0C7yHRK5bPrLRlWyW3XPZSZtJSKk6c3s46eZTj2uR41yxhvJCV9bLGLqQDMw67
         PssvyhKKmGfYXSodEwyQaM6Jv3kWGWDq3Ub+tEFOn/45LoSMAuDKZikvhcd9/bEFImJ7
         jzE7kXKj+5WIS0NA5BNmnFKdQL7JkDZdliKaqKGmMNG+MXOPkliPEXuVRVluRT65FEPy
         qC8A==
X-Gm-Message-State: ACrzQf2PGYY/1VOd+KRuTcyGotAJssGkMmmqfQ0tpkq+OSIfrr6HBT6W
        FGqsliUAYH4zjSQ0M6+Eqhy+hQ==
X-Google-Smtp-Source: AMsMyM4/WHsXfITyAI0IugOgOx31A5fznQp16dYMdte4llM4Z4CbwJ0/MjjOpbI0HV/ufYx0+kNiAg==
X-Received: by 2002:a17:902:c1c6:b0:186:994f:6e57 with SMTP id c6-20020a170902c1c600b00186994f6e57mr23483233plc.17.1667378745459;
        Wed, 02 Nov 2022 01:45:45 -0700 (PDT)
Received: from localhost ([122.172.84.80])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902784a00b00172fad607b3sm7662379pln.207.2022.11.02.01.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 01:45:45 -0700 (PDT)
Date:   Wed, 2 Nov 2022 14:15:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, rafael@kernel.org, johan@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/3] Qcom CPUFreq HW driver cleanups
Message-ID: <20221102084543.e65wjxtk5p2fkuwo@vireshk-i7>
References: <20221102083239.53826-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102083239.53826-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-11-22, 14:02, Manivannan Sadhasivam wrote:
> Hello,
> 
> This series contains cleanup patches targeting the Qcom CPUFreq HW driver.
> This is a spun off of the clock provier series [1].
> 
> Thanks,
> Mani
> 
> [1] https://lore.kernel.org/lkml/20221025073254.1564622-2-manivannan.sadhasivam@linaro.org/T/

On what have you rebased it ? This should be based of my cpufreq/arm/linux-next
branch.

-- 
viresh
