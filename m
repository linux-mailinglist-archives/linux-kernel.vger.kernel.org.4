Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C329680F42
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236154AbjA3Nqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235504AbjA3Nqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:46:33 -0500
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Jan 2023 05:46:31 PST
Received: from smtpcmd0987.aruba.it (smtpcmd0987.aruba.it [62.149.156.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F5B15552
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:46:31 -0800 (PST)
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id MUTPp35dC1uCfMUTPpl5ku; Mon, 30 Jan 2023 14:45:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1675086328; bh=SHJyHui5zOsg78nOi+x9KjRAzGa6YUx9oLlYvFANGP8=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=bKF4yJmFxii4n7STENx9DdYHzJgqqgXSGJuoa33xpKJpLVnhNhsdA2XnfrQ7oyB5u
         Fb4BkyzElxJfQBQF1EEP6jAreNBnhbfSIfGvvnz19C7OKj5AlS6nRfHyrcvx7g9ybJ
         pXRZ5xm9sYzL+9aCmCTEFtxqaRVegT3vNedTE+ci0E+wdjut/BwAmh+7oe5uQOI6cV
         KVcorxQ8UDciHg3fUJ0jMUlOj7M8YaEXLFg9aKxFYxVJ4YCpzGADm4uUtNRbTsFBqG
         nMAyma9ct+/DmnOdUUWC/O51vPx4W541wlmNx3YYjehnz75p+ffoj1BosfKplzpwfO
         k3v+hpE6hhJFA==
Message-ID: <fa3f1765-eb59-bf69-7f7b-14621caef6ea@enneenne.com>
Date:   Mon, 30 Jan 2023 14:45:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: PPS functionality for Intel Timed I/O
Content-Language: en-US
To:     "N, Pandith" <pandith.n@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>
References: <BYAPR11MB3240A86B426158623DB9983EE1D39@BYAPR11MB3240.namprd11.prod.outlook.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <BYAPR11MB3240A86B426158623DB9983EE1D39@BYAPR11MB3240.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJjfrVdnufnvClFqupD2x86OEVR0RGtgkrUbP4lM5KS7YliuU5ypE5oTdWVmm4VgJlGDrRK9uMbzP19MqIX+0rjHFdsrKIbT7Zs0WDm+kzQKTDWq2CZX
 pq5hlpYmHm70sshxoB04rz19fAETUjvMQ8lyoZ/8yJEItKEElLI77T0x4J3F76GSalOXoN23t6hVy3m8JdVRmcAxbIYbxAdRQ405JIW/i1RmH4w5vv6F8Sps
 j4ssxX4ifay8ZPHK8Li3+yrP78DhBtOPyeSUi88+o+s5mm5GsGp6i0cL8cg/FYfh8GdKl7ciTBn/05XClyv4wCAauzVdQkuUy+R/78gQl/7YScJmaJ7s/YY6
 yl4AF90bNfX6remTcSV79FUHvf18U7lJP/TGZzD2IVApHx4r9nFuNJpAIKe+mD0BtsZjBzIR
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/23 13:55, N, Pandith wrote:
> Hi Rodolfo Giometti,

Hello.

> This is regarding Intel Timed I/O device as PPS.
> 
> Intel Timed I/O is a precise device (10s of nanoseconds), that can send out pulses.
> This is needed in IoT and server applications to measure offset between system clocks on multiple devices

Can you please provide some URLs where to get further info from about this 
device? I'd like to know how this device works and its interfaces towards the CPU.

> We are planning to implement a driver, for PPS output functionality using Timed I/O device.

Great! :)

> 	1. Is there any support from PPS framework to start/stop pulse generation.
> 	If yes, can we get the Pin number, offset(start time) from user space ?

Nope, PPS signals are supposed to be always on. However you can start/stop 
pulses generation within the main driver of your device.

> 	2. Further, this device has the capability to capture the input events (pulses, nanosecond precision).
> 	The same PIN can work in either input or output mode.
> 	Can there be an PPS client driver supporting both modes ?

I'm not sure to well understand what you mean, however a PPS client is a piece 
of code that captures PPS pulses and add a timestamp to them, while a PPS 
generator is a piece of code that (precisely) generates a PPS source according 
to the system's main clock (and not according to a peripheral's clock). Hope 
I've answered to your questions, if not feel free to ask more.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

