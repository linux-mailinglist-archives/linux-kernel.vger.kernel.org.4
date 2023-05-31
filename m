Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F67717630
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 07:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbjEaFad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 01:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjEaFa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 01:30:29 -0400
Received: from out0-197.mail.aliyun.com (out0-197.mail.aliyun.com [140.205.0.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573D911B;
        Tue, 30 May 2023 22:30:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047204;MF=changxian.cqs@antgroup.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---.THCuFeH_1685511019;
Received: from 30.177.18.117(mailfrom:changxian.cqs@antgroup.com fp:SMTPD_---.THCuFeH_1685511019)
          by smtp.aliyun-inc.com;
          Wed, 31 May 2023 13:30:20 +0800
Message-ID: <170fa8d4-7851-cc1a-14ba-7213d0a5da0c@antgroup.com>
Date:   Wed, 31 May 2023 13:30:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] samples: rust: add `SgTable` and `ScatterList`
 selftests
To:     Boqun Feng <boqun.feng@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "=?UTF-8?B?55Sw5rSq5Lqu?=" <tate.thl@antgroup.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Gary Guo" <gary@garyguo.net>,
        "=?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>,
        "Benno Lossin" <benno.lossin@proton.me>,
        "Martin Rodriguez Reboredo" <yakoyoku@gmail.com>,
        "Asahi Lina" <lina@asahilina.net>,
        "Sven Van Asbroeck" <thesven73@gmail.com>,
        "Viktor Garske" <viktor@v-gar.de>, "Finn Behrens" <me@kloenk.dev>,
        <rust-for-linux@vger.kernel.org>
References: <20230530064821.1222290-1-changxian.cqs@antgroup.com>
 <20230530064821.1222290-3-changxian.cqs@antgroup.com>
 <2023053003-antitoxic-popcorn-b1ab@gregkh> <ZHZBacreRpd0D/FV@boqun-archlinux>
From:   "Qingsong Chen" <changxian.cqs@antgroup.com>
In-Reply-To: <ZHZBacreRpd0D/FV@boqun-archlinux>
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


On 5/31/23 2:33 AM, Boqun Feng wrote:
> On Tue, May 30, 2023 at 08:31:26AM +0100, Greg KH wrote:
>> On Tue, May 30, 2023 at 02:48:21PM +0800, Qingsong Chen wrote:
>>> Add a selftest module to provide a temporary place to put "pure tests"
>>> for Rust funtionality and wrappers.
>> Is this for in-kernel tests, or userspace tests?  If userspace, you
>> should follow the proper test reporting protocol the rest of the kernel
>> uses.  If in-kernel, it should follow the format that the in-kernel test
>> currently has to be consistent.  From what I could tell here, you aren't
>> following either, but I might be totally wrong.
>>
> It is for in-kernel tests, and you're right, we should follow the other
> in-kernel test format.
>
> Some explanation about the background: when I was working on this little
> "test framework", the Github CI of Rust-for-Linux (ab)used sample/rust/
> for testing, that's why it was put there.
>
> Now my understanding is that Rust KUnit support is coming, so we should
> use kunit tests if possible.

Maybe I should place those use cases in the doc ( `Examples` section) 
and remove this commit

in next version. Thanks.


