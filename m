Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6923E721D25
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 06:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjFEE3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 00:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjFEE3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 00:29:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10815BD;
        Sun,  4 Jun 2023 21:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=bI4+f0K/M38ZLx1MlePFnQTc3sx8ulFXm4dSPoSUv0Q=; b=SkyE34zd52CBb3F3H10xeZYosn
        FFHBePVYJN/WUbjQA2mHBtnU+hHWUruwEKTACsKOlO+jYuPR8w2hUCqcUIfikNczlG/sWz8N/hClB
        SxXxt1JXuUqqqsMMLkWsoE06WQ/N2HQf9+2AwwS5n0W4moFKcycftLNh4X4xwLWRVl6qZ7+lnx3T6
        rdhi95/Kwt6HRPqGBWmAJykulkBr7YeZhL4lZ6r5aAhbEdPE916dTbZsTdHL8DNd4vYLHfwixYUdg
        rFTolF7cF8nXo6WDiKedkndlW7EnsH4pKnzzDiwdJOnu1SBSURuoN/yxd3tsPXFR4g01nEMzRP1HE
        nFBsAD5w==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q61pv-00E5MP-30;
        Mon, 05 Jun 2023 04:28:55 +0000
Message-ID: <16135856-b79e-02ab-2b0b-d98a523dda76@infradead.org>
Date:   Sun, 4 Jun 2023 21:28:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 -next] tty: serial: add panic serial helper
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Hongyu Xie <xiehongyu1@kylinos.cn>, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, corbet@lwn.net
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        xy521521@gmail.com, oe-kbuild-all@lists.linux.dev, lkp@intel.com,
        Linux Documentation <linux-doc@vger.kernel.org>
References: <20230605015957.730085-1-xiehongyu1@kylinos.cn>
 <ZH1e3tuuie3bGhPj@debian.me>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZH1e3tuuie3bGhPj@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bagas--

On 6/4/23 21:04, Bagas Sanjaya wrote:
>> diff --git a/Documentation/dev-tools/panic_serial_helper.rst b/Documentation/dev-tools/panic_serial_helper.rst
>> new file mode 100644
>> index 000000000000..fc5b6e9103bc
>> --- /dev/null
>> +++ b/Documentation/dev-tools/panic_serial_helper.rst
> The file name convention is using hyphens (like
> panic-serial-helper.rst).

I found over 300 counterexamples, so I don't think that it's a big deal.

-- 
~Randy
