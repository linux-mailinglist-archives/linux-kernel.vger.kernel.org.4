Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F396413ED
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 04:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbiLCDF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 22:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiLCDFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 22:05:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B7CF7A09;
        Fri,  2 Dec 2022 19:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=LphjCQHgonOvj2WAQOeFN1xSmSlk2x3OOoL6G9U5ImI=; b=qp3ORkw5mp+gPX6hf1mEgqPIA7
        ADcPBunnJXRp3oCZ+zWRVKTCE1hum6DLfhbjWB+PO3ez4bRg3GaRWUSIR/z/GWvgoDhLDOSAnQOzv
        OJg0VU4x9lZz8QFlOtKYPODecfBG3XjFIID1lwDYR1anz7r+hFe5U/pJHvVRfGE0tpfsff/UX1iQQ
        9+bshskas2au87aAfRwua5DWpOm3zQ1IGTIYBQnbmZmTVL+oB0GTCwnIa84F7nczNa7x4Cj8Xl/w/
        VNrfEaRNCYKUlvzU4+J1x/5V5YIf/8mt7cKYfFXpcJixho028HeLd0NnKTPqmXsjosJURoHNZ8SQu
        W1sCpE8Q==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p1IqW-002AdU-8m; Sat, 03 Dec 2022 03:05:44 +0000
Message-ID: <774fd22a-aaee-758d-8195-77bac783ecbc@infradead.org>
Date:   Fri, 2 Dec 2022 19:05:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: linux-next: Tree for Dec 2 (drivers/platform/x86/intel/ifs/ifs.h)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Borislav Petkov <bp@suse.de>
References: <20221202152654.261139e6@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221202152654.261139e6@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/1/22 20:26, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20221201:
> 

Documentation build warning:

../drivers/platform/x86/intel/ifs/ifs.h:223: warning: Function parameter or member 'test_num' not described in 'ifs_data'

comes from:
commit 4fb858f3dcd2
Author: Jithu Joseph <jithu.joseph@intel.com>
Date:   Wed Nov 16 19:59:33 2022 -0800

    platform/x86/intel/ifs: Add current_batch sysfs entry


Jithu, please send a patch for this.

-- 
~Randy
