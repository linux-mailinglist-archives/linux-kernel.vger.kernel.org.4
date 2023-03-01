Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D7F6A6BB2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjCAL3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCAL3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:29:42 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EEE1BAD6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 03:29:41 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id s18so7512484pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 03:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=so75AWYc+LDPBId0ihyF/Z4pXQ0Tben7XkRYW6Mi+Ow=;
        b=OEh0ykBYQAEXunvVTgTyGtXpk5/Onq+Sasev8EFdDboLSnzQ1O/VbK6QntgeDNct2I
         Mph516/nPvqGr8eEFi+OmhvMPQQxM+GJPMT/8UIyuA+qh5jJbhZUOmKYTs7yMgFOQ9C1
         tOdDiLQeEzdykeylHkkLl5e7F19uwbpb8QEFBMXBQ8Pu//taC9tuVajdRbPSOaIxmsM3
         8fqftq+3Tzh83pyUH8Q9YNucvPXy2Z3R1RFqKGHFtFMsWrPMyfjYf8LSVCIWeDMUKnlr
         OPcr9ENoXl9UuXjDgutzBb5QWAbbMPYxTEFybglqZ0ZrCnmRTuhed1nroy+SBkm7YEKt
         a96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=so75AWYc+LDPBId0ihyF/Z4pXQ0Tben7XkRYW6Mi+Ow=;
        b=LKItzEzk5tfErcj1zq1nO2ZKa/2lwhm/+ZEEtl0DeeL7wphkZdKcHblI8wbQf1N99c
         cr9b3FsgvKOWqq8Gbnbt7d9F9eafgCliibTjaGBzIEJHm7h8OKnPm7q47zCNLqhGrOJo
         PLkwbrxpcGBt9qaBYd85mJikYkyE2ESMHeFIMNyljUUhOiPo9eHoOh3cmbeIkL+GSpTH
         BXuJP4W/g1JmZQIjS3j8O9fofNchNqv9tku7usWimc9umeTDxXvLlkk9tTKXSytlg9eR
         D36feGBM55SNrhCSfpRwBaY1eCwtN4JBBMX31idr97EdbLja7K/3AQiiOuAeYlfdEpqW
         GYFQ==
X-Gm-Message-State: AO0yUKWX25WkQyOwA1KpulHk5H3mJ4exDX6OJ2xoKsIFkD7+VuN2PdI3
        2XD+vUarv5YP2wGMnCF8PR+H
X-Google-Smtp-Source: AK7set8TKPEfZJEQkHUJEboXZF3OSzh4GQXOEMaoLHmy2UlSWgYwB0K9/qfV51IAclkkbotvSFmlPQ==
X-Received: by 2002:a62:5e43:0:b0:5d2:1d72:3b31 with SMTP id s64-20020a625e43000000b005d21d723b31mr5305084pfb.2.1677670180572;
        Wed, 01 Mar 2023 03:29:40 -0800 (PST)
Received: from thinkpad ([220.158.159.248])
        by smtp.gmail.com with ESMTPSA id x6-20020aa793a6000000b005e093020cabsm7642523pff.45.2023.03.01.03.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 03:29:40 -0800 (PST)
Date:   Wed, 1 Mar 2023 16:59:35 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/16] Qcom: Fix PCI I/O range defined in devicetree
Message-ID: <20230301112935.GD5409@thinkpad>
References: <20230228164752.55682-1-manivannan.sadhasivam@linaro.org>
 <c5e36887-f84d-40ef-bef9-8a3947bbb73f@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5e36887-f84d-40ef-bef9-8a3947bbb73f@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 05:58:37PM +0100, Arnd Bergmann wrote:
> On Tue, Feb 28, 2023, at 17:47, Manivannan Sadhasivam wrote:
> > Hi,
> >
> > This series fixes the issue with PCI I/O ranges defined in devicetree of
> > Qualcomm SoCs as reported by Arnd [1]. Most of the Qualcomm SoCs define
> > identical mapping for the PCI I/O range. But the PCI device I/O ports
> > are usually located between 0x0 to 64KiB/1MiB. So the defined PCI addresses are
> > mostly bogus. The lack of bug report on this issue indicates that no one really
> > tested legacy PCI devices with these SoCs.
> >
> > This series also contains a couple of cleanup patches that aligns the entries of
> > ranges property.
> 
> Looks good to me. I already commented that we may also want to use
> 64KB everywhere instead of 1MB for the per-host window size.

I also spotted this discrepancy while working on this series, but the size
seems to be not universal across SoCs from many vendors. So I settled with
whatever range that was used before.

>  Regardless of that, please add
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> I would also prefer to do this in fewer patches, maybe one to
> change all the prefixes, and another one to change the location,
> or whichever way Bjorn prefers.
> 

Well, the only intention of doing a per-patch change is to backport them if
needed. But I'll defer it to Bjorn.

Thanks,
Mani

>      Arnd

-- 
மணிவண்ணன் சதாசிவம்
