Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564DA747EFA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjGEIGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbjGEIF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:05:58 -0400
Received: from mail.lineo.co.jp (mail.lineo.co.jp [203.141.200.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AAA12A;
        Wed,  5 Jul 2023 01:05:56 -0700 (PDT)
Received: from [172.31.7.30] (vpn1.lineo.co.jp [203.141.200.204])
        by mail.lineo.co.jp (Postfix) with ESMTPSA id 23F9B80354A98;
        Wed,  5 Jul 2023 17:05:55 +0900 (JST)
Message-ID: <3b6a61b6-1bb7-187b-481b-22d551bb8dc3@lineo.co.jp>
Date:   Wed, 5 Jul 2023 17:05:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Rust for linux build error due to Clang (bindgen) version
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Yuta Hayama <hayama@lineo.co.jp>
References: <327e5e5a-5aec-316f-c4b1-b1dfcbb4c44c@lineo.co.jp>
 <CANiq72kZeLs1oWbUeZtx3CkGQxMa3Qnn3neV_yEfC+T_D-xtww@mail.gmail.com>
From:   Yuta Hayama <hayama@lineo.co.jp>
In-Reply-To: <CANiq72kZeLs1oWbUeZtx3CkGQxMa3Qnn3neV_yEfC+T_D-xtww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for your response!

On 2023/07/05 3:28, Miguel Ojeda wrote:
> On Tue, Jul 4, 2023 at 11:06 AM Yuta Hayama <hayama@lineo.co.jp> wrote:

>> Does this mean we need something like max-tool-version.sh? But that might be
>> a bit silly... If such "error occurs because the tool is too new" is repeated
>> in the future, I feel that it is necessary to check not only the lower limit of
>> the tool version, but also the upper limit.
> 
> `make rustavailable` already warns for "too new" versions for `rustc`
> and `bindgen`.

Yes, I checked this. What I was noticed is that these tools have the same
lower and upper limits for the required version. (so min-tool-version.sh
was sufficient.) Since there is a range between the lower and upper limits
for Clang, I thought that if we are going to do version checking, we need
to extend min-tool-version.sh or something related to it.

> We could add something like that (as error or warning)
> for `libclang` too, but that particular issue goes away with the
> upgrade in place, so (at least for mainline) it is OK.

I understand that at least this issue will be fixed in the near future (v6.6?).
I will wait and see for a while...


Regards,

Yuta Hayama
