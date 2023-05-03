Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D791E6F618F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 00:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjECWxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 18:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjECWxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 18:53:31 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCE94690
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 15:53:29 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-2f3fe12de15so3660668f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 15:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683154408; x=1685746408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MV+u++8U/VyhhrcbPmfUOej8gTWnvvepSCv4nFZxUI8=;
        b=z5utn/AknJmxABeeRVynXmrhi4Oc97sCAjDb0iazJnDQSytpF8KGji4soAzXjh3azn
         cMWsjo42IeqqY92VWWLtdc7hw79ElV2ID9oKUfRnof6bYHtHzbrg7hHC2neqLKdeGH3S
         k2nB2kQE4Glvq1bE5PfuuHykCxOJsUilzEXa1b233gF4ZwKA0A8PNTu3tQxwOpLWr4EQ
         ByhdUaiTQboKN3+ocuPT8NLcmzrKLPq5N6pEyxf7krf4HttW1cxvTuCxFXojD9y9wILT
         ZfszlfNZMQiB1b0u/NY6HtV/nNbCaCApTy0dj8PzIMXDZslWZgLbi0ysG3Kio00D3WfZ
         BIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683154408; x=1685746408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MV+u++8U/VyhhrcbPmfUOej8gTWnvvepSCv4nFZxUI8=;
        b=DdK7uSv+brAp2ihfccdNdHXYVaAVw5vucFUE6gKgvrLc9jKj4G0Vbu7V22rwpCPxIK
         JhjJ593vhkSQakOizNhFAQ0yeJ+tty8C6GJz1L/GgPeQm8VLNCYwAlLwR/eDdjBc5Vy8
         bpFL/Sj+0AIOUXPE7PzJjomypDVQkayWOkAKzZOxL513NxlqdGyaRvEvPVN2ah0OAjYG
         4UUG+VctqibovXkBrTARTDJ2I69ZKYYaJwmUzab5P+du2spOKZX25gdhDQF50YV4YwNw
         R8LO0k0vx/RkLvPHKBPRjlccsn1EwwzXDdZQhBF2PThejF/hFSyNin+Yybxm5nyag/TX
         84fg==
X-Gm-Message-State: AC+VfDyX4J170LslHy7NfrsyN65hakGqReX3G3TRicKWTJpxbHAKiKGr
        /RExILxLTDPrakxIZ81oSOIvcFCybkbOeAEwrb1LWA==
X-Google-Smtp-Source: ACHHUZ5eigr8TCDr+H/MP1064+RlRfGKo2BIQBROvCuaV76YQsBFIGMIvr/fz2VEdwTBR1By0hRozA==
X-Received: by 2002:adf:ec0b:0:b0:304:8888:87ad with SMTP id x11-20020adfec0b000000b00304888887admr1072529wrn.12.1683154408135;
        Wed, 03 May 2023 15:53:28 -0700 (PDT)
Received: from [192.168.0.15] (cpc76484-cwma10-2-0-cust274.7-3.cable.virginm.net. [82.31.201.19])
        by smtp.gmail.com with ESMTPSA id k9-20020a5d6d49000000b003068f5cca8csm334471wri.94.2023.05.03.15.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 15:53:27 -0700 (PDT)
Message-ID: <575ee047-c6ce-95c3-8781-8c9a78534bb1@linaro.org>
Date:   Wed, 3 May 2023 23:53:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V4 2/3] soc: qcom: boot_stat: Add Driver Support for Boot
 Stats
Content-Language: en-US
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1681742910.git.quic_schowdhu@quicinc.com>
 <C1eDJi-H9uWRAtbInRclmCgPb4EcgaeS3sk5FKO9cw8KscgMCH8dxRSvdPGUMwDFKpte7cBVeaqPhlLog-CRrg==@protonmail.internalid>
 <2ef76ce292c059c144e559123a9a54201ae2d0cf.1681742910.git.quic_schowdhu@quicinc.com>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <2ef76ce292c059c144e559123a9a54201ae2d0cf.1681742910.git.quic_schowdhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/04/2023 16:08, Souradeep Chowdhury wrote:
> All of Qualcomm's proprietary Android boot-loaders capture boot time
> stats, like the time when the bootloader started execution and at what
> point the bootloader handed over control to the kernel etc. in the IMEM
> region. This information is captured in a specific format by this driver
> by mapping a structure to the IMEM memory region and then accessing the
> members of the structure to show the information within debugfs file.
> This information is useful in verifying if the existing boot KPIs have
> regressed or not. The information is shown in milliseconds, a sample
> log from sm8450(waipio) device is as follows:-
> 
> /sys/kernel/debug/146aa6b0.boot_stats # cat abl_time
> 17898 ms
> /sys/kernel/debug/146aa6b0.boot_stats # cat pre_abl_time
> 2879 ms
> 
> The Module Power Manager(MPM) sleep counter starts ticking at the PBL
> stage and the timestamp generated by the sleep counter is logged by
> the Qualcomm proprietary bootloader(ABL) at two points-> First when it
> starts execution which is logged here as "pre_abl_time" and the second
> when it is about to load the kernel logged as "abl_time". Documentation
> details are also added in Documentation/ABI/testing/debugfs-driver-bootstat
> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>

Hi,

[...]
> +
> +static int boot_stats_probe(struct platform_device *pdev)
> +{
> +	struct device *bootstat_dev = &pdev->dev;
> +	struct bs_data *drvdata;
> +
> +	drvdata = devm_kzalloc(bootstat_dev, sizeof(*drvdata), GFP_KERNEL);
> +	platform_set_drvdata(pdev, drvdata);
> +
> +	drvdata->dbg_dir = debugfs_create_dir(dev_name(bootstat_dev), NULL);

This might be better as just "qcom_boot_stats", rather than including
the address.

[...]
> +
> +static const struct of_device_id boot_stats_dt_match[] = {
> +	{ .compatible = "qcom,sm8450-bootstats" },

This driver doesn't only support sm8450, I've tested this on sdm845 and
it works just fine. Can we use a generic compatible here instead?
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, boot_stats_dt_match);
> +
> +static struct platform_driver boot_stat_driver = {
> +	.probe  = boot_stats_probe,
> +	.remove_new = boot_stats_remove,
> +	.driver = {
> +		.name = "qcom-boot-stats",
> +		.of_match_table = boot_stats_dt_match,
> +	},
> +};
> +module_platform_driver(boot_stat_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm Technologies Inc. Boot Stat driver");
> +MODULE_LICENSE("GPL");
> --
> 2.7.4
> 

-- 
Kind Regards,
Caleb (they/them)
