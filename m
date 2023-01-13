Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576F3668A5D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 04:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjAMDqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 22:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjAMDqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 22:46:43 -0500
Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com [115.124.28.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82368EE14;
        Thu, 12 Jan 2023 19:46:39 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1366565|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0193387-0.00120227-0.979459;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=28;RT=28;SR=0;TI=SMTPD_---.QrTXrBT_1673581583;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.QrTXrBT_1673581583)
          by smtp.aliyun-inc.com;
          Fri, 13 Jan 2023 11:46:33 +0800
From:   wangweidong.a@awinic.com
To:     povik+lin@cutebit.org
Cc:     13691752556@139.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, cezary.rojewski@intel.com,
        ckeepax@opensource.cirrus.com, daniel.beer@igorinstitute.com,
        devicetree@vger.kernel.org, flatmax@flatmax.com,
        james.schulman@cirrus.com, jonathan.albrieux@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, liweilei@awinic.com, lkp@intel.com,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        pierre-louis.bossart@linux.intel.com, rf@opensource.cirrus.com,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org, steve@sk2.org,
        tiwai@suse.com, wangweidong.a@awinic.com,
        yangxiaohua@everest-semi.com, yijiangtao@awinic.com,
        zhaolei@awinic.com
Subject: Re: [PATCH V9 4/5] ASoC: codecs: Aw883xx chip register file, data type file and Kconfig Makefile
Date:   Fri, 13 Jan 2023 11:46:23 +0800
Message-Id: <20230113034623.188604-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <5EA7B038-9B49-4E5D-8209-8689C0D03071@cutebit.org>
References: <5EA7B038-9B49-4E5D-8209-8689C0D03071@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/1/2023, at 9:38, povik+lin@cutebit.org wrote:
> Hi,

> the issue here would be that it’s possible to select your driver for compilation without
> having selected the CRC8 functions, leading to the linkage error.

> You can fix that by adding ’select CRC8’ under the Kconfig section of your driver, similarly
> to how the SND_SOC_SIGMADSP symbol selects CRC32.

Thank you very much for your advice. I will correct this mistake

> Best regards,
> Martin

Best regards,
Weidong Wang
