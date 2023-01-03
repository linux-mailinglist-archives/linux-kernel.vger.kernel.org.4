Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1201865C5B0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbjACSHb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Jan 2023 13:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbjACSH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:07:29 -0500
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB8798
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:07:27 -0800 (PST)
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay03.hostedemail.com (Postfix) with ESMTP id 490D7A09E3;
        Tue,  3 Jan 2023 18:07:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 9EDE92000D;
        Tue,  3 Jan 2023 18:07:23 +0000 (UTC)
Message-ID: <ae5f6ddce8e52a3de2ad460aaa3f4a83ee0a866c.camel@perches.com>
Subject: Re: [PATCH] scripts/spelling: add a few more typos
From:   Joe Perches <joe@perches.com>
To:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org
Cc:     colin.i.king@gmail.com, dfustini@baylibre.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 03 Jan 2023 10:07:22 -0800
In-Reply-To: <20230103175901.128262-1-sj@kernel.org>
References: <20230103175901.128262-1-sj@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 9EDE92000D
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: j6pduect6aquy3cfbghp9nqf3fi1u63p
X-Rspamd-Server: rspamout05
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+KHeis1yG9zMeUFgt6CLESLPBLMTz7zh0=
X-HE-Tag: 1672769243-135599
X-HE-Meta: U2FsdGVkX18RIvdWnPcbht8ZXzLJvXuzN0VqL6RJmGncA5jcQy1ex7CQPYdsWo/iEG58FPmcT4P6LBvG8yM5dg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-01-03 at 17:59 +0000, SeongJae Park wrote:
> Add a few more typos that found from real patches[1,2] to 'spelling'
> file.

Most of these are fine but:

> diff --git a/scripts/spelling.txt b/scripts/spelling.txt
[]
> @@ -411,6 +411,7 @@ contruction||construction
>  contry||country
>  conuntry||country
>  convertion||conversion
> +covert||convert

Covert is a correctly spelled english word that could be used
appropriately for some security issues.

For instance:

security/keys/key.c: * security issues through covert channel problems.

Another possibility would be to fix the existing dozen or so misuses/typos.

$ git grep -i -w covert
Documentation/virt/kvm/x86/timekeeping.rst:4.8. Covert channels and leaks
arch/mips/cavium-octeon/executive/cvmx-pko.c:    * per word count. Multiply by 8 to covert to bits and divide
arch/powerpc/include/asm/vas.h:  * CP_ABORT to clear any pending COPY and prevent a covert
arch/powerpc/kernel/process.c:   * any state and prevent snooping, corruption or a covert
arch/powerpc/platforms/pseries/iommu.c: /* covert to number of tces */
arch/powerpc/platforms/pseries/iommu.c: /* covert to number of tces */
arch/sparc/kernel/chmc.c:/* Covert syndrome code into the way the bits are positioned
drivers/crypto/cavium/cpt/cptpf_main.c:         /* Covert requested cores to mask */
drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c: * directly, taking care to covert such fields to little endian. The request
drivers/net/wireless/mediatek/mt76/mt7915/mmio.c:       /* CONN_INFRA: covert to phyiscal addr and use layer 1 remap */
drivers/net/wireless/mediatek/mt76/mt7996/mmio.c:       /* CONN_INFRA: covert to phyiscal addr and use layer 1 remap */
drivers/rtc/rtc-mt6397.c:       /* rtc_tm_to_time64 covert Gregorian date to seconds since
drivers/staging/media/ipu3/include/uapi/intel-ipu3.h: * The demosaic fixed function block is responsible to covert Bayer(mosaiced)
drivers/usb/typec/rt1719.c:     /* covert mV/mA to uV/uA */
fs/iomap/buffered-io.c: * beyond EOF in this case as writeback will never write back and covert that
include/linux/spi/ad7877.h:     u8      pen_down_acc_interval;  /* 0 = covert once, 1 = every 0.5 ms,
scripts/Makefile.build:# Make $(LD) covert LLVM IR to ELF here.
security/keys/key.c: * security issues through covert channel problems.


