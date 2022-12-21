Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5636536F3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 20:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbiLUTUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 14:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiLUTU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 14:20:29 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4670C252A4;
        Wed, 21 Dec 2022 11:20:27 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bf43so24948146lfb.6;
        Wed, 21 Dec 2022 11:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rFdn33bs7BmDd8WaWCi9E6exzjuQGIF80TAJQSNIHgk=;
        b=DXQ7snjR47yMDBO73trIfi2AmY8Ob2eMD7cZ3ogeZ4jyg3hIaJklDHDBbmdbBk08+T
         tghZPtKh/BmM4QVR0/WOu8EBljuea0PxVfUkrk1DW3ii00mDs5kV4E+EnJTTrkUcMgm3
         rKY80aqcktCuhbZTYnSOfh1P7fsPTcYIH2YyhRL/Xu50hlDF5sH62wpkCDQ/UdIl0vK/
         uaxNHgRxEl+5Dan+kNJb+kTASiG1qUeTbytrGU8RoDcGiMBGA2Zki3q5bdgKgqpsOFw1
         XLt8lRxzSSSRIlUKH6A1xCjJq8w5tBcBDrON/i4vX4ijrhw28f0MYTZs3v8Ecakl6Bsn
         GAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rFdn33bs7BmDd8WaWCi9E6exzjuQGIF80TAJQSNIHgk=;
        b=0UjCGQsx5UtLt3igaw06+GFtQS+PBzFjx+IwMeGWncEuFQAQ1wO1y0kiY0WrMmzPNV
         aUzhTLfjO85BzIfZkVbVEvhK5zCh/BidKYfP+7YL5t+xSxfhEOPAdGJ9lk5AQuRqSguw
         QaTACRWyzoEmJmxtbV0Tt7IuhMQn20aAfez1W+DMEKmAnczCe8n+ShqV9Az7mDDEb+1e
         aKFzlcCo+VOzrkoQhQC/QgUB2fxOEZIm76GkElF+P/Epk22EIF965LTdnVonENkF5t4z
         TbJCqBEjnkfiuMcK5gZu5SDEI4lnW0P69jNIXa4PO1exiENo0Y1rzCxEl8g1bStkZavQ
         rltA==
X-Gm-Message-State: AFqh2krITitks7jXIwWSVmagQ7HXfis312AdYSiTwUcxs+rEtLe2kBMT
        iJKmSu8g9o3uta5aiCVqS9M=
X-Google-Smtp-Source: AMrXdXvcO7vQrnQ2fi6XfM/8UfOEa8uSL/zz4u74fiEksqTQC7I8CFIx5yJJp2zE5mb1P2OGkVcrhQ==
X-Received: by 2002:a19:7606:0:b0:4b5:32ec:7eb6 with SMTP id c6-20020a197606000000b004b532ec7eb6mr904247lff.0.1671650425709;
        Wed, 21 Dec 2022 11:20:25 -0800 (PST)
Received: from [192.168.2.145] (109-252-113-89.nat.spd-mgts.ru. [109.252.113.89])
        by smtp.googlemail.com with ESMTPSA id x14-20020a056512078e00b004a1e104b269sm1925752lfr.34.2022.12.21.11.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 11:20:25 -0800 (PST)
Message-ID: <62fc4a96-bab8-4d43-5278-3375e34431e7@gmail.com>
Date:   Wed, 21 Dec 2022 22:20:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [Patch v1 01/10] memory: tegra: add interconnect support for DRAM
 scaling in Tegra234
Content-Language: en-US
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
> +
> +	/*
> +	 * Same Src and Dst node will happen during boot from icc_node_add().
> +	 * This can be used to pre-initialize and set bandwidth for all clients
> +	 * before their drivers are loaded. We are skipping this case as for us,
> +	 * the pre-initialization already happened in Bootloader(MB2) and BPMP-FW.
> +	 */
> +	if (src->id == dst->id)
> +		return 0;
> +
> +	if (mc->curr_tnode->type == TEGRA_ICC_NISO)

The mc->curr_tnode usage looks suspicious, why you can't use src node?

