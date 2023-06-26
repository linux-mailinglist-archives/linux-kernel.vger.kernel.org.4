Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2780073D64B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 05:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjFZD03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 23:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjFZD0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 23:26:22 -0400
Received: from out0-222.mail.aliyun.com (out0-222.mail.aliyun.com [140.205.0.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B3D187;
        Sun, 25 Jun 2023 20:26:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047198;MF=changxian.cqs@antgroup.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---.TdoSam9_1687749973;
Received: from 30.177.49.172(mailfrom:changxian.cqs@antgroup.com fp:SMTPD_---.TdoSam9_1687749973)
          by smtp.aliyun-inc.com;
          Mon, 26 Jun 2023 11:26:14 +0800
Message-ID: <c720663e-8743-956d-2ece-c9ca23f94d3a@antgroup.com>
Date:   Mon, 26 Jun 2023 11:26:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 1/8] rust: kernel: add basic abstractions for
 device-mapper
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "=?UTF-8?B?55Sw5rSq5Lqu?=" <tate.thl@antgroup.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        "=?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>,
        "Benno Lossin" <benno.lossin@proton.me>,
        "Martin Rodriguez Reboredo" <yakoyoku@gmail.com>,
        "Alice Ryhl" <aliceryhl@google.com>,
        "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>,
        "Asahi Lina" <lina@asahilina.net>, <rust-for-linux@vger.kernel.org>
References: <20230625121657.3631109-1-changxian.cqs@antgroup.com>
 <20230625121657.3631109-2-changxian.cqs@antgroup.com>
 <2023062544-speech-impish-9308@gregkh>
From:   "Qingsong Chen" <changxian.cqs@antgroup.com>
In-Reply-To: <2023062544-speech-impish-9308@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/23 8:25 PM, Greg KH wrote:
> Shouldn't this be all different commits, and different files?  A bio
> shouldn't be defined in the device_mapper.rs file, as that would prevent
> anyone else from accessing it.

Yes, you're right. Since we noticed that some block layer patches[1]
are under review, we don't put much effort into that. Actually, we
don't want to include all the `bio` implementation in this patchset,
so it just some dummy codes.

If necessary, a seperate commit could be splited, including things
that do not belong to the device mapper.

[1]: 
https://lore.kernel.org/rust-for-linux/20230503090708.2524310-5-nmi@metaspace.dk/

Thanks,
Qingsong Chen
