Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D53681326
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbjA3O2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbjA3O2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:28:25 -0500
Received: from smtpcmd0987.aruba.it (smtpcmd0987.aruba.it [62.149.156.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EA641B70
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:26:57 -0800 (PST)
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id MV7Xp3g2V1uCfMV7XpldLE; Mon, 30 Jan 2023 15:26:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1675088815; bh=e8NGCjc1PlwlSsZxif43o4vwmPiRH2O6127tM1dE+OA=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=au9A75hxhjG79imlhPzScKWuzzth6v29DrH+GJgqberbqGkcaHmmwjxIiuP+tG1u2
         pVGKXBXJuX+mzK20poGyzbYUZSitCH9Rz5z8TiGxJp08qt4JluTRB3FSVYAsN+noon
         j6RjEHvHHrifBYy9LTzb9IGkiwmKXaCbXo6OlaBcp8C1lgHL8CWILbIOvOl3TiSBRr
         pvP7SKHVGfcbxwA86fnnTo7F/uHvqvSNNyy4Jp76+YhbQSKQDjOWFUmWJ5OMDwqhHZ
         ROwhRyUZoTjPyjgZ9b0wvKCKo2I/TWbDaBZxP3FQkBOyeg1FIVfVfzMBv0W5mUcC1r
         XoV269Oupzqhw==
Message-ID: <1e02cc71-baee-1e75-9160-062d563af795@enneenne.com>
Date:   Mon, 30 Jan 2023 15:26:55 +0100
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
 <fa3f1765-eb59-bf69-7f7b-14621caef6ea@enneenne.com>
 <BYAPR11MB3240801F21598EEFAEA79605E1D39@BYAPR11MB3240.namprd11.prod.outlook.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <BYAPR11MB3240801F21598EEFAEA79605E1D39@BYAPR11MB3240.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNtfD6XrX5uR8B8DrYd9DMy5DPABifGl3y+wtggaZB6C9hGgQECgyKj1NaZVFwIxRu1ZdpZajXM/DH0g3QBTvjXitR2gNbcZH1ALLB2rI/79F7G3CpLd
 9z3LMSq12I06Bh0uTc66FozZMqv4zFA6eNMO+ktoCsFOeMqkLK0n9+2pm0NRdy2QRBQy2waXibwhZLbFAiT+RdBP5bzj6JwKvV+lHLIXlzU4ZLL/uovV/LpC
 IHcPHdohAN2pw2okAXC5XOb2CWWOBTLyEYEyFVjHmk5IN/3L3k/FgfpSTvzazum3UwB6Ow6L9E0ikO6ZWG8vjjBLkomNxwwlBaaILBO1EXc3UUQ7C2Kfks/Y
 C0uEJLhN776/iZadPfHLwfcytNLzzrjoq8ty9HXGJJ9lBinM5oLGufOWIbbzr/bGwdBpul/j
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/23 15:11, N, Pandith wrote:
> Here is a presentation link for Timed I/O device
> https://lpc.events/event/16/contributions/1387/attachments/1051/2010/Timed_IO_LPC.pdf

Thanks. I'll take a look at it.

> Intel Timed I/O PIN has both generator functionality and input capability.
> Wanted to ask if it’s better to have two separate drivers, one under client
> for input and other as generator driver for PPS output.
> OR
> Have a single client driver and user can choose the functionality (either
> PPS output or as PPS source to capture pulses with timestamps).
Within kernel sources PPS clients and PPS generators are placed into different 
directories, so I suppose is better to deploy two different pieces of code.

However pay attention to the fact that a PPS generator should be referred to 
system's main clock and not to peripherals' clock.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

