Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DDC6B39FF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjCJJQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjCJJPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:15:41 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1281F76179
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:11:47 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l7-20020a05600c1d0700b003eb5e6d906bso2916634wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678439506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hxe94wucfwiIxdubvu53KSQWuqpnJ5N5K+N2JaQRnG0=;
        b=RNvrlQHWfGAAswhueOK43XkddWxDdcbn00PkJKQ3R14urHwbOmO48UbDEZ4stUyKLS
         J3JlbjMDGo8VjOroxddALvzjqMwEuI0+3wS5hnv96sYq0Br9sXLRhunWOUoGyPSDwAND
         lvJ5D6V5EcQW7MoSqZYOjYKSAyhJgWyhfWQ3qMJg5QU/GJdNq/gKeXw2jemJrST44Si0
         3tUucouwjA78IcpqH1yeA4a3L2gx198y59/tA4g/xaXU1BYuoo1M5ImN9hdDFTRh2lYz
         v+cV1a8zwAmuCzHGYP45BbhfqxYpggH/8pnSrtzAss+mMo/wPDEWd8zs/AsaMhLIhFGm
         xIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678439506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxe94wucfwiIxdubvu53KSQWuqpnJ5N5K+N2JaQRnG0=;
        b=HAmOpDg19sLCPKJCXJ/IRmsepk0SurEQaCzQ3tXjcZAetWToqpRmacBIi7xoJFCOIf
         it8zZ9k6HC0JOiLoaZiKurTy8jmkdixs2iS8VOlu0gffSi5CITGjZgCu1rfcNbdszTyt
         pBgzvqnEaA1Gar96iJyRS6WtQ4nS4mezRMSrtL8Y6AmzNsnAsVJz2od2YJjoIPskFFe/
         bSiD7Vub7q6g3+tCcL2OBlfQBzi7uITiO8/6vwcsXSqpk8PnY4oIF3DyogMHbRLSuH3v
         CNeL/vawvJh8yohsY/i/l3IqVWuhPjcJaBXY0UhPwIfWhiY71jFNrbOofI5s+isAoj9a
         hdhQ==
X-Gm-Message-State: AO0yUKXnAKf/Q+IVTtNK/9GxJRp5AYecVQl9M3AfTPhHuMwFarMXvPAo
        zwdiHeg8U+FqP/EX2E1V7q8=
X-Google-Smtp-Source: AK7set90kAs3T7CZZ23UNLeDlH1k1Nx56UCt9ooh3U48+i31Rb60ANX98xJlVoeqdCsflxCCipslQg==
X-Received: by 2002:a05:600c:468b:b0:3ea:e667:b1ee with SMTP id p11-20020a05600c468b00b003eae667b1eemr2045911wmo.38.1678439506199;
        Fri, 10 Mar 2023 01:11:46 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i21-20020a05600c355500b003e214803343sm2476787wmq.46.2023.03.10.01.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 01:11:45 -0800 (PST)
Date:   Fri, 10 Mar 2023 12:11:41 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     "jia-wei.chang" <jia-wei.chang@mediatek.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com, Nick <vincent@systemli.org>
Subject: Re: [PATCH v1 2/3] cpufreq: mediatek: fix KP caused by handler usage
 after regulator_put/clk_put
Message-ID: <67024b47-f3c9-4764-9883-d52602cfefca@kili.mountain>
References: <20230310051750.4745-1-jia-wei.chang@mediatek.com>
 <20230310051750.4745-3-jia-wei.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310051750.4745-3-jia-wei.chang@mediatek.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 01:17:49PM +0800, jia-wei.chang wrote:
> From: "Jia-Wei Chang" <jia-wei.chang@mediatek.com>
> 
> Any kind of failure in mtk_cpu_dvfs_info_init() will lead to calling
> regulator_put() or clk_put() and the KP will occur since the regulator/clk
> handlers are used after released in mtk_cpu_dvfs_info_release().
> 

This patch is harmless but it's not required.

If the mtk_cpu_dvfs_info_init() function is not able to complete
successfully then it cleans up all the partial allocations.  If it is
able to allocate everything successfully, then the caller, which is
mtk_cpufreq_probe(), adds it to the &dvfs_info_list.  If the
probe() function is not able to complete successfully it releases
everything in the &dvfs_info_list.

In this way, mtk_cpu_dvfs_info_init() never frees anything which has
not been allocated and it never frees anything which has already been
freed.  All the IS_ERR() checks in mtk_cpu_dvfs_info_release() can be
removed.

In reviewing this code, I can't help but notice that mtk_cpu_dvfs_info_init()
is buggy.  Please read my blog on error handling:
https://staticthinking.wordpress.com/2022/04/28/free-the-last-thing-style/

drivers/cpufreq/mediatek-cpufreq.c
   411          info->cpu_clk = clk_get(cpu_dev, "cpu");
   412          if (IS_ERR(info->cpu_clk)) {
   413                  ret = PTR_ERR(info->cpu_clk);
   414                  return dev_err_probe(cpu_dev, ret,
                        ^^^^^^^^^^^^^^^^^^^^
Here we have a direct return which means there is nothing to free.
Okay.

   415                                       "cpu%d: failed to get cpu clk\n", cpu);
   416          }
   417  
   418          info->inter_clk = clk_get(cpu_dev, "intermediate");
   419          if (IS_ERR(info->inter_clk)) {
   420                  ret = PTR_ERR(info->inter_clk);
   421                  dev_err_probe(cpu_dev, ret,
   422                                "cpu%d: failed to get intermediate clk\n", cpu);
   423                  goto out_free_resources;
                        ^^^^^^^^^^^^^^^^^^^^^^^
The last thing we successfully allocated was ->cpu_clk so ideally the
goto would be something like "goto put_cpu_clk;".  Let's assume this
clk_get() fails.


   424          }
   425  
   426          info->proc_reg = regulator_get_optional(cpu_dev, "proc");
                ^^^^^^^^^^^^^^
Note that this is where ->proc_reg is allocated.  Prior to that point
it is NULL because it's allocated with kzalloc().

   427          if (IS_ERR(info->proc_reg)) {
   428                  ret = PTR_ERR(info->proc_reg);
   429                  dev_err_probe(cpu_dev, ret,
   430                                "cpu%d: failed to get proc regulator\n", cpu);
   431                  goto out_free_resources;
   432          }

[ snip ]

   536  out_free_resources:
   537          if (regulator_is_enabled(info->proc_reg))
                                         ^^^^^^^^^^^^^^
Oops!  This is a NULL dereference because ->proc_reg wasn't allocated
yet.

   538                  regulator_disable(info->proc_reg);
   539          if (info->sram_reg && regulator_is_enabled(info->sram_reg))
   540                  regulator_disable(info->sram_reg);
   541  
   542          if (!IS_ERR(info->proc_reg))
   543                  regulator_put(info->proc_reg);
   544          if (!IS_ERR(info->sram_reg))
   545                  regulator_put(info->sram_reg);
   546          if (!IS_ERR(info->cpu_clk))
   547                  clk_put(info->cpu_clk);
   548          if (!IS_ERR(info->inter_clk))
   549                  clk_put(info->inter_clk);
   550  
   551          return ret;
   552  }

It would be safer and more readable to have:

err_put_inter_clk:
	clk_put(info->inter_clk);
err_put_cpu_clk:
	clk_put(info->cpu_clk);

etc.

regards,
dan carpenter

