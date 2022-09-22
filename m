Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96D25E6769
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbiIVPoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiIVPoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:44:02 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F076DFCA51
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:43:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bq9so16226849wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=+pCd7iFQ72tC9LNIKqBaoNiSRgJmjL7SUHChHdrDwEc=;
        b=vm34oqXFNOZ9EyfCD5DaHHO0TqDTw2uHnBfgS786sRZdzxHMYzyeRttxQ7cEG1Wd29
         ILcyjEOqtv4rSUJlJ6jGvzdlbxk3SxfOCagZRICnQTgeVc8BeV8mtKRiRdnCaUfNGDMD
         JU6Pul+Ndey7kcRM1U2vDxIv7VnxCk9tiKzIE3zgMnaRfPGdu3LYtuufjdY8QgAseGZJ
         MVoTU6vHqjmBmGsEOYym4cFS3ao3ji0Z9r/OFW5EpCASX0MPlRDho4TbOHpA5Ng4NF8z
         ncsQwvwHBTlUs9du0joWY2srsNWuauoS8xDwt/SWDqWYskIP7R5xPo7UYUSPmQcr+1+n
         GLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=+pCd7iFQ72tC9LNIKqBaoNiSRgJmjL7SUHChHdrDwEc=;
        b=6yMpa0w8AIZkdaIjes7T2xNd9JlEs9JMvfq1JgnwWpyayUsyO8PIkiiq2kvhCZrrtF
         rUOpBRQdADz3qvJiO4lS2MePlF2tS9Usm1paNDL4uj1MtXcz8OmUek4d6eyOld1T+VFn
         51VhH9/jNzP3lvtPPBY8BTTJdhuhu8ef9/zFR0zounyqANfVwgvaBEKnF34USNyXwkfF
         wW5kiGQ0f7rc3oa2t1Mqw+0cyk3GoeAGU5ZwuAzTbBBF9YpWozst5bbnhqnIGwauEDny
         i0ZHendHt64vxFQ6MQW6XvfC6OM0Orse6qe0BOQIZR+hWdG1USJbcPguLcI6/IvxSA59
         QQoQ==
X-Gm-Message-State: ACrzQf3LZDAC7Q5LHQtB8s0EQJr0183sS3RGyW2fIAs5hewmlJCvzek4
        Lp5ISJSjKCW1EFj799j+Q86+/ZTPJw3nVA==
X-Google-Smtp-Source: AMsMyM5sPNQO3l57B9PDsKrSRdZ1zT1Miu46w0+2G9BWCWvACjrQe9/Ioo9GSEX/jKyviECa5N1xbQ==
X-Received: by 2002:adf:de01:0:b0:228:62ae:78bc with SMTP id b1-20020adfde01000000b0022862ae78bcmr2419097wrm.41.1663861410665;
        Thu, 22 Sep 2022 08:43:30 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id d10-20020a056000114a00b002250c35826dsm5249731wrx.104.2022.09.22.08.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 08:43:30 -0700 (PDT)
Date:   Thu, 22 Sep 2022 16:43:26 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>, mark.rutland@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: Add QEMU compatible strings
Message-ID: <YyyCnmZvqDryZSAt@myrica>
References: <20220916132959.1910374-1-jean-philippe@linaro.org>
 <0acc2a21-27c2-ec85-0335-263d70c24469@linaro.org>
 <87mtaxltwm.wl-maz@kernel.org>
 <e89478b5-8495-a846-61ff-917bc4e08490@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e89478b5-8495-a846-61ff-917bc4e08490@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2022 at 09:50:58AM +0100, Krzysztof Kozlowski wrote:
> > As for the patch, I'd remove the QEMU reference and the deprecation.
> > This format is perfectly allowed, and is in use in most VMMs out
> > there. Yes, DT is an ABI.
> 
> Thanks for the explanation, actually enough was to say that it is
> perfectly valid combination describing hardware. :)
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks Krzysztof, I'll rework the commit message and resend

Thanks,
Jean
