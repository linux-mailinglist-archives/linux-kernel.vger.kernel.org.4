Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D586EFB23
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 21:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239072AbjDZTdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 15:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjDZTde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:33:34 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86407114;
        Wed, 26 Apr 2023 12:33:33 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b35789313so5441818b3a.3;
        Wed, 26 Apr 2023 12:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682537613; x=1685129613;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eYBYIGZHucPLTSByJfrCBaN6ehgBJpC1xsBVnDP8WrQ=;
        b=Dr0oqFY0QLlBjQuAAjEQ9o0QIpETLtD40zM7B4EkHNKEqsCvSCiwSFBAIouCs2+Epv
         RGYx9q/U5Xwl8eri2mBd/oTNRtjqMj63eNLZ4GYtoAtF7Udznp5kuv+An+kRkAQ7g7zm
         SCLeqk25NROJtDA5ID0xqDtak+/2BnnYvT2PaGdHjCYLF1z04FocBdcwFA+vuqdpZK/d
         yb3lMpDAMxqOLchqmGwMYB+2xoMnMzJDemUECGv9pERnNBaTsajzzsSdWPLzYTMhTr1x
         YugmwickLskQX+3elmkmn4JuGEErPXSjAiRNGlg0FdEt64FPfWkMzjsIwrxohFHstZDx
         vWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682537613; x=1685129613;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eYBYIGZHucPLTSByJfrCBaN6ehgBJpC1xsBVnDP8WrQ=;
        b=VsClqtFC64g1KlBWoHLOp81TSBpXKZ+lJrUEds87rKCHdEye1bCbS32pFA9DrE2Qu8
         aoV2m2hPn/j+mTSfMDlkR4YSYvuU4U5+uhnpfGzuJYwtRb+yLsuOAN+e6pM/cCwSoASB
         u1be+JfzISctrXqMsavWhVA0W8Xf6cJX6AX+it+bDAjMJB8CTPwOCbZ2DYdlsXdO4+S7
         M04PcbM3CX567GJQ/lHWen71Ye0VSRkS41xlJ3xGgR/sZZDTHHDkPwpFnpjrrDMQL9vQ
         PJX0XyJKiaDQUHi7wYt8QZcZXK8dAe4UImcyzBTUv3dKXeOjuy9bxRIHHXlWIagPiFua
         OipQ==
X-Gm-Message-State: AAQBX9chg8I2lw8564CiHZt0Fhs2s62MmzPrmNfi0YO6LgdalheNKtlB
        E9UPuiEldyhBLqkpzEIuE7fnaMgtWZ7k6A==
X-Google-Smtp-Source: AKy350YvLpk9rePGnJccamIxfFfl7J3mqUnyqhKjhZ05OuOKovsJsWB8ulwwagz1du7CyqOynYST3A==
X-Received: by 2002:a05:6a20:4288:b0:ef:95ee:895a with SMTP id o8-20020a056a20428800b000ef95ee895amr28995838pzj.30.1682537612748;
        Wed, 26 Apr 2023 12:33:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id k24-20020a6568d8000000b00520b677c645sm10112024pgt.41.2023.04.26.12.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 12:33:32 -0700 (PDT)
Message-ID: <501fd57a-b952-82c1-9139-828f972a2ba6@gmail.com>
Date:   Wed, 26 Apr 2023 12:33:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [Patch 3/6] irqchip/gicv3: Export arm_smccc_get_soc_id_xx funcs
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>, viresh.kumar@linaro.org,
        rafael@kernel.org, ionela.voinescu@arm.com, mark.rutland@arm.com,
        sudeep.holla@arm.com, lpieralisi@kernel.org,
        catalin.marinas@arm.com, will@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
        sdonthineni@nvidia.com, sanjayc@nvidia.com, ksitaraman@nvidia.com,
        bbasu@nvidia.com
References: <20230418113459.12860-1-sumitg@nvidia.com>
 <20230418113459.12860-4-sumitg@nvidia.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230418113459.12860-4-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/23 04:34, Sumit Gupta wrote:
> Export arm_smccc_get_soc_id_version() function which is needed
> in CPPC_CPUFREQ to check and apply workaround for Tegra241 SoC.
> Also, exporting arm_smccc_get_soc_id_revision() function as it
> might be needed in future.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>

The commit subject seems off, maybe you re-used the last one that was 
done in the tree (35727af2b15d irqchip/gicv3: Workaround for NVIDIA 
erratum T241-FABRIC-4), it should rather be: "firmware: smccc: Export 
arm_smccc_get_soc_id_xx funcs"
-- 
Florian

