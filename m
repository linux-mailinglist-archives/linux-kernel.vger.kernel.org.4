Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A376536E9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 20:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbiLUTRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 14:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiLUTRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 14:17:20 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBF32611E;
        Wed, 21 Dec 2022 11:17:19 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id z26so24926103lfu.8;
        Wed, 21 Dec 2022 11:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+uxVp29zK1U9xqn1zesUpsJ7wtKfj/klzX/8Mo0DipY=;
        b=k9n/vLc1Ln9JuOJ9y6I7pgOBKKJBGQu4c1HrIUkkH8HWULQuVFdqoLCXX+VXaLlv2s
         o2y5QNtz4jDOzOatLmoleU5m2pb/pbATmCTX7iZKvF+DiUWlLhYOepu5YqNSEcrc81v0
         dnczF5Lqg1XrqFZKxgU9vaS+194bsFvM3sXdeqrZsuVGyzv4cmB9LHWFsDf/SfaR0BL+
         2arV2TKoXqtA/kaWSbF3d7kU4QsxXt8G7rb4qEVV7fc1mpkfl5eeF9phFvJ/BvIXwGY/
         OKz1F1RDDxuogy5D3eBW7HgTSPAtKLzu6JjYJ+jBOtOjYWFLlko1L0AG5PXzqO5PUIZo
         2GYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+uxVp29zK1U9xqn1zesUpsJ7wtKfj/klzX/8Mo0DipY=;
        b=MvzmzcPuSAeUfH9Ve2+UHQJQqVNMDTH8pjazyFGV77l08irpkjUGnWtZy9SqA7qBo0
         ixXtDryCPTSKBgz4Tvh8nm+pF8saMPZMgt0CwozABaefNJg8frySyK/P9+gUVPLAc3ez
         h7OZDMfkWy3Yf9Q47kM7MNlF0CZ+otfbzuRMjKGUGG7FTRlpSESmm+dLlSiNETV6k1re
         dAxbbg0m6N6GWqZ7spjtoAQP3Pj69nkqaxoHBnXX18fRYP5OfExnfariwR2hI4mABbd4
         lYqDUj3R8tD85YeUbo4tIKXPxO6uwhiy0wKvNeguZIWHzkGMAaAdnzKWgi1GEDacszUY
         mztg==
X-Gm-Message-State: AFqh2kpJ4USMyZo/hOjUgaIJ6A0kakDn18yrUmkuRmQ32RxRrtGwmfJC
        6STczZ107yctc9Xs7KLhJZ1xlCdDWFM=
X-Google-Smtp-Source: AMrXdXthbVDOO69Gmd6f89kU7JTCY7m46ohAqAUosDAVrcLMSE6ki2WmoGXSrSGZAR4wooeOElE2ow==
X-Received: by 2002:a05:6512:25ac:b0:4b5:8053:5bcc with SMTP id bf44-20020a05651225ac00b004b580535bccmr858751lfb.47.1671650237875;
        Wed, 21 Dec 2022 11:17:17 -0800 (PST)
Received: from [192.168.2.145] (109-252-113-89.nat.spd-mgts.ru. [109.252.113.89])
        by smtp.googlemail.com with ESMTPSA id o3-20020ac24e83000000b004c7d0ed9619sm1155581lfr.123.2022.12.21.11.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 11:17:17 -0800 (PST)
Message-ID: <ccebb92b-01ce-31cf-14b1-dee09d064c6c@gmail.com>
Date:   Wed, 21 Dec 2022 22:17:09 +0300
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
Cc:     sanjayc@nvidia.com, ksitaraman@nvidia.com, ishah@nvidia.com,
        bbasu@nvidia.com
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-2-sumitg@nvidia.com>
Content-Language: en-US
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20221220160240.27494-2-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.12.2022 19:02, Sumit Gupta пишет:
> +static int tegra_emc_icc_set_bw(struct icc_node *src, struct icc_node *dst)
> +{
> +	struct tegra186_emc *emc = to_tegra186_emc(dst->provider);
> +	struct tegra_mc *mc = dev_get_drvdata(emc->dev->parent);
> +	struct mrq_bwmgr_int_request bwmgr_req = { 0 };
> +	struct mrq_bwmgr_int_response bwmgr_resp = { 0 };
> +	struct tegra_icc_node *tnode = mc->curr_tnode;
> +	struct tegra_bpmp_message msg;
> +	int ret = 0;

Nit: unnecessarily initialized var, the same for the rest of the code

