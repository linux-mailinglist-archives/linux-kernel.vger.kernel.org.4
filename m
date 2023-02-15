Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C9E697EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 15:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjBOOxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 09:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBOOxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:53:09 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B222439B8D;
        Wed, 15 Feb 2023 06:53:06 -0800 (PST)
Received: from host86-157-192-115.range86-157.btcentralplus.com ([86.157.192.115] helo=[192.168.1.218])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1pSJ9d-0007e4-6t;
        Wed, 15 Feb 2023 14:53:05 +0000
Message-ID: <0f5aafed-7b1a-99ac-57fc-c5de9a269b92@youngman.org.uk>
Date:   Wed, 15 Feb 2023 14:53:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [dm-devel] RAID4 with no striping mode request
Content-Language: en-GB
To:     Roger Heflin <rogerheflin@gmail.com>,
        Heinz Mauelshagen <heinzm@redhat.com>
Cc:     Kyle Sanderson <kyle.leet@gmail.com>, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        John Stoffel <john@stoffel.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
References: <CACsaVZJvXpCt37nQOoe8qd1EPUpfdMM1HwHk9tVO8HdU_Azhhw@mail.gmail.com>
 <25578.37401.314298.238192@quad.stoffel.home>
 <CACsaVZJ-5y7U5xqwL9bof69EKbTk+wrHWFcBFYyP_BwVSt+CNA@mail.gmail.com>
 <CAM23Vxr8LkkcVDFfW1=qEYGgo7JG1qx62eWSV4WOw4_MnD+TZA@mail.gmail.com>
 <CAAMCDeeHxMBoVkNYAyssjgjo4=FYd2NonS-mqC7OUEL89B9Cig@mail.gmail.com>
 <CAM23VxpzY6qYsdTYxe01FT7AJvEbODf8X_vq8ALL35TfyrB8xQ@mail.gmail.com>
 <CAAMCDee2hV1YP=119Rorz1uGTnyBD5q9hb20PvMq89FHow2wPw@mail.gmail.com>
From:   Wols Lists <antlists@youngman.org.uk>
In-Reply-To: <CAAMCDee2hV1YP=119Rorz1uGTnyBD5q9hb20PvMq89FHow2wPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2023 11:44, Roger Heflin wrote:
> WOL: current SSD's are rated for around 1000-2000 writes.  So a 1Tb
> disk can sustain 1000-2000TB of total writes.  And writes to
> filesystem blocks would get re-written more often than data blocks.
>   How well it would work would depend on how often the data is deleted
> and re-written.

When did that guy do that study of SSDs? Basically hammered them to 
death 24/7? I think it took about three years of continuous write/erase 
cycles to destroy them.

Given that most drives are obsolete long before they've had three years 
of writes ... the conclusion was that - for the same write load - 
"modern" (as they were several years ago) SSDs would probably outlast 
mechanical drives for the same workload.

(Cheap SD cards, on the other hand ...)

Cheers,
Wol
