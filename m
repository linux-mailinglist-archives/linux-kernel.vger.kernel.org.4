Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A3C7191CE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 06:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjFAEXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 00:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjFAEXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 00:23:15 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94561123
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 21:22:53 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f60e536250so12586445e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 21:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685593372; x=1688185372;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nEUSKakM7CgssIHutSLLFBuhQcpvKDHSFouStIGCbKI=;
        b=RJBR4CEyV3X3OY/66TlP2daq0Rg6bP8ppblEDDuLG57vuDzCrzb6BuivmIg/RALiDR
         fbPFTpkcVtl6Gjo1B1h5Q2lCPLdmF0wTm/IKTAG1ycjGTEg7NI1+6Qm9YWPuuZedJ4QU
         kMng0r4JpU2v/GEjrcSCV3qAyZV2iWy2pUS9RaDzL7iHHa8I5Nv4broTDS5iy/9klq4m
         jqBGwZM9OcmEjXWjfA7G71F968LpNMxUnEtHl81FKC/JDxrCNvGn9xR9VA11dgws2fi6
         lYQ61V77p4+XTiBZhTerevzHmhoXDMmAAUqDWZyGE0snB3qI4kHOepofoB6Iv0PQjWYL
         nZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685593372; x=1688185372;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nEUSKakM7CgssIHutSLLFBuhQcpvKDHSFouStIGCbKI=;
        b=Mv/zOiAyrZT0ejrnjx7XEkuPZ+rBrv00om5bbxF3xlXmbisvsCUIPXvyhi7jjzltbE
         jivjn1TmCw7SFd/bpethGEQ1zK+//7hf0rhawG/wRVBkXP4ogkRxaXXaZBwRmY5uL1xo
         9toH4BAFpgO/GJuXsmJOlsR4KjkndivFwIgij3aLL2gDZ92A/eUbI39mkWj+aT7SYNZr
         FXOed5JvT+DNkcigq6q8ABK6bRwZoSBf7il345YWn1C0mIfAO7LZ6Q7ps4TQqsLWn/JM
         pAQ+lzKOL5nkCnCU8GGlT7HN3a/bI7qxTbbfPDZaEcZOmDKnQxEQM+M2rePNmsF0yJMr
         7ljQ==
X-Gm-Message-State: AC+VfDyrI/1ZQ8uOqtOpwUhBQ4DObnn6YOhIx/8VGeCM2vEYKJ5t54sr
        UPr8d0dPcAv1H3S4wenTtrOo+g==
X-Google-Smtp-Source: ACHHUZ609qLhj2H/vRP631y1n+nwPXyNCW7my8BlllAeUfXlVV61oluu11j+zaNfSk14DUmH/SdmoA==
X-Received: by 2002:a5d:484f:0:b0:309:5029:95a9 with SMTP id n15-20020a5d484f000000b00309502995a9mr405031wrs.32.1685593372011;
        Wed, 31 May 2023 21:22:52 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a14-20020adfe5ce000000b003078354f774sm8789259wrn.36.2023.05.31.21.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 21:22:49 -0700 (PDT)
Date:   Thu, 1 Jun 2023 07:22:45 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: drivers/platform/x86/thinkpad_acpi.c:10538 dytc_profile_refresh()
 error: uninitialized symbol 'funcmode'.
Message-ID: <09b823d3-4bad-456f-bf30-3221354e33f9@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   929ed21dfdb6ee94391db51c9eedb63314ef6847
commit: 1bc5d819f0b9784043ea08570e1b21107aa35739 platform/x86: thinkpad_acpi: Fix profile modes on Intel platforms
config: i386-randconfig-m021-20230531 (https://download.01.org/0day-ci/archive/20230601/202306011202.1hbgLRD4-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202306011202.1hbgLRD4-lkp@intel.com/

New smatch warnings:
drivers/platform/x86/thinkpad_acpi.c:10538 dytc_profile_refresh() error: uninitialized symbol 'funcmode'.

Old smatch warnings:
drivers/platform/x86/thinkpad_acpi.c:1193 tpacpi_new_rfkill() warn: 'atp_rfk->rfkill' is an error pointer or valid
drivers/platform/x86/thinkpad_acpi.c:2606 hotkey_inputdev_close() warn: bitwise AND condition is false here
drivers/platform/x86/thinkpad_acpi.c:3776 hotkey_notify_hotkey() warn: bitwise AND condition is false here
drivers/platform/x86/thinkpad_acpi.c:10531 dytc_profile_refresh() error: uninitialized symbol 'output'.
drivers/platform/x86/thinkpad_acpi.c:10537 dytc_profile_refresh() error: uninitialized symbol 'output'.

vim +/funcmode +10538 drivers/platform/x86/thinkpad_acpi.c

c3bfcd4c676238 Mark Pearson  2021-01-11  10515  static void dytc_profile_refresh(void)
c3bfcd4c676238 Mark Pearson  2021-01-11  10516  {
c3bfcd4c676238 Mark Pearson  2021-01-11  10517  	enum platform_profile_option profile;
6229ce9c36384c Hans de Goede 2022-03-09  10518  	int output, err = 0;
fde5f74ccfc771 Mark Pearson  2023-01-12  10519  	int perfmode, funcmode;
c3bfcd4c676238 Mark Pearson  2021-01-11  10520  
c3bfcd4c676238 Mark Pearson  2021-01-11  10521  	mutex_lock(&dytc_mutex);
42504af775361c Mark Pearson  2022-06-03  10522  	if (dytc_capabilities & BIT(DYTC_FC_MMC)) {
7a47f86bba748b Mark Pearson  2021-04-06  10523  		if (dytc_mmc_get_available)
7a47f86bba748b Mark Pearson  2021-04-06  10524  			err = dytc_command(DYTC_CMD_MMC_GET, &output);
7a47f86bba748b Mark Pearson  2021-04-06  10525  		else
c3bfcd4c676238 Mark Pearson  2021-01-11  10526  			err = dytc_cql_command(DYTC_CMD_GET, &output);
1bc5d819f0b978 Mark Pearson  2023-01-24  10527  		funcmode = DYTC_FUNCTION_MMC;
1bc5d819f0b978 Mark Pearson  2023-01-24  10528  	} else if (dytc_capabilities & BIT(DYTC_FC_PSC)) {
e1c21608e3cfc4 Mark Pearson  2022-02-25  10529  		err = dytc_command(DYTC_CMD_GET, &output);
1bc5d819f0b978 Mark Pearson  2023-01-24  10530  		/* Check if we are PSC mode, or have AMT enabled */
1bc5d819f0b978 Mark Pearson  2023-01-24  10531  		funcmode = (output >> DYTC_GET_FUNCTION_BIT) & 0xF;
1bc5d819f0b978 Mark Pearson  2023-01-24  10532  	}

funcmode not initialized on else path.  err is also 0 on the else path.

c3bfcd4c676238 Mark Pearson  2021-01-11  10533  	mutex_unlock(&dytc_mutex);
c3bfcd4c676238 Mark Pearson  2021-01-11  10534  	if (err)
c3bfcd4c676238 Mark Pearson  2021-01-11  10535  		return;
c3bfcd4c676238 Mark Pearson  2021-01-11  10536  
c3bfcd4c676238 Mark Pearson  2021-01-11  10537  	perfmode = (output >> DYTC_GET_MODE_BIT) & 0xF;
fde5f74ccfc771 Mark Pearson  2023-01-12 @10538  	convert_dytc_to_profile(funcmode, perfmode, &profile);
c3bfcd4c676238 Mark Pearson  2021-01-11  10539  	if (profile != dytc_current_profile) {
c3bfcd4c676238 Mark Pearson  2021-01-11  10540  		dytc_current_profile = profile;
c3bfcd4c676238 Mark Pearson  2021-01-11  10541  		platform_profile_notify();
c3bfcd4c676238 Mark Pearson  2021-01-11  10542  	}
c3bfcd4c676238 Mark Pearson  2021-01-11  10543  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

