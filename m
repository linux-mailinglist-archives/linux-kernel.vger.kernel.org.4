Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27DA6525F8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbiLTSGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbiLTSGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:06:07 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A04DCB;
        Tue, 20 Dec 2022 10:06:06 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id g14so13201497ljh.10;
        Tue, 20 Dec 2022 10:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a3At5LfgBql0UNtiOgDh4DPYrtPHXYddjsEEIRrbnJs=;
        b=f0bg937Lq/73vV9pMGqk60uP1RUahXUU99EoguO4EEZqO2L73d7GxNvupBFH24sMJQ
         wQ1nxImg/I+lY41sYg/ijxaNaexAmGhlIRz2z8hj65PupJdZ4fqr5FIq7XzYrkpD7kPx
         JHzy+3OZjo/0MaUmS00G05/9P5g5yEnnCeMX6Cftvl2FXAWv5Jq/oBG+YWCIL8eLl7kF
         jbgqjo4ajSP55tW37UHp6Lf2lkprys52nHYWpEraiSgFbCASIYTQUc5cmyIswcA1Zta1
         TQbmgZdq3KWWaCPk8UgPeGGApB2NFY5NszR51ehDniXXVb0J7St+xpAHsFbIRJehV4R2
         14QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a3At5LfgBql0UNtiOgDh4DPYrtPHXYddjsEEIRrbnJs=;
        b=A5FkYq0SjD2MBN02E9PgkmQB+6N5FUSt6/N3GOOww+Blx/4NCpu8sZ15b0P9jo+PrT
         d3kT8pRUj4SPXJ0gSJsWu8Ky6vW5k8QRetLROrqeI5n2PLQiKxjNUd55wufHTM07fzpc
         klejDd0Eq9chqSCkTtcHdyDeTcxuafs80PQN4LTb/qVyOWhmprx0tfgCl68BukIHQWah
         Tf5uyrtEGdM1LcH4blbsXNqRGm5qB1bpY1GosaUUSA8pOJZuUghSuAlWPMnmkX4GngiF
         JQVJ0q6CrD2Y3tQ2fLm0PwPlJ5hLtV4CJYl7ZM07senvpSEnhYLJTY/Zu/aURR33MJXm
         ZZFQ==
X-Gm-Message-State: ANoB5pl/4UTRLPCFER1paoyO0csF63+19DkE1eT3M0FDzUo1Ut6apzY/
        gFXxWoDNKEPT9zBMrLyPlKg=
X-Google-Smtp-Source: AA0mqf4+1BxJsqVQldi3Kw1LBbwNJluKCkw4CJT6W2/T82UQbv012NczV2SkWDzWrgchNyOvdWC8Og==
X-Received: by 2002:a05:651c:98d:b0:278:e5ce:f551 with SMTP id b13-20020a05651c098d00b00278e5cef551mr12204853ljq.10.1671559564365;
        Tue, 20 Dec 2022 10:06:04 -0800 (PST)
Received: from [192.168.2.145] (109-252-113-89.nat.spd-mgts.ru. [109.252.113.89])
        by smtp.googlemail.com with ESMTPSA id z14-20020a05651c11ce00b0027f770526ebsm843958ljo.75.2022.12.20.10.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 10:06:03 -0800 (PST)
Message-ID: <8e7f0efb-dc90-9dc7-015e-a2d56630f495@gmail.com>
Date:   Tue, 20 Dec 2022 21:05:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [Patch v1 01/10] memory: tegra: add interconnect support for DRAM
 scaling in Tegra234
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        krzysztof.kozlowski@linaro.org, dmitry.osipenko@collabora.com,
        viresh.kumar@linaro.org, rafael@kernel.org, jonathanh@nvidia.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-2-sumitg@nvidia.com>
Content-Language: en-US
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20221220160240.27494-2-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.12.2022 19:02, Sumit Gupta пишет:
> @@ -779,6 +780,7 @@ const char *const tegra_mc_error_names[8] = {
>   */
>  static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
>  {
> +	struct tegra_icc_node *tnode;
>  	struct icc_node *node;
>  	unsigned int i;
>  	int err;
> @@ -792,7 +794,11 @@ static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
>  	mc->provider.data = &mc->provider;
>  	mc->provider.set = mc->soc->icc_ops->set;
>  	mc->provider.aggregate = mc->soc->icc_ops->aggregate;
> -	mc->provider.xlate_extended = mc->soc->icc_ops->xlate_extended;
> +	mc->provider.get_bw = mc->soc->icc_ops->get_bw;
> +	if (mc->soc->icc_ops->xlate)
> +		mc->provider.xlate = mc->soc->icc_ops->xlate;
> +	if (mc->soc->icc_ops->xlate_extended)
> +		mc->provider.xlate_extended = mc->soc->icc_ops->xlate_extended;

These IFs look pointless
