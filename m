Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87D37076AE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 02:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjERACB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 20:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjERAB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 20:01:57 -0400
Received: from sonic311-31.consmr.mail.ne1.yahoo.com (sonic311-31.consmr.mail.ne1.yahoo.com [66.163.188.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26319DB
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684368115; bh=lBk328IPZrZb1JzxFoVLsw1vpStQSw63jKeqdVarP0g=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=Z4lERBcSZKc3IoI0cbHF5m70xrrkV1eIzlYBu3nzCe4X00Wj7D9tjuYi+yIpW7NUWMWtjODXgoxFmrQRj9P6O4rZnXvzsJKxLs10XPeZLMvGRW0KYBGEzBe3h5K4zk7jfIpx6f5PlzVCgKoHQ6UyiwF0rvtCk9iw0f35ed7UIVhacGu5UjZ4YGk+Ijbh1BQ8TVpQNJbCwOC90Z3QhQCjw98IcWyMaNU6KitZ5V8FM+yOmesouWjCIuluR8/4GCMCHEED+XuzfYUJDAYgXGGss6St9W+lLiG1uQruJZYPsEfhSScfMZ+RLQx/0cmkjiMlaoDJsU/FVDVQuEzIWQuqEg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684368115; bh=tKxxBvYAm1vIB2MFG6Appq4dxPfufd/i7w4JUESKsTh=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ZV+mzCVXd7gpk1sAWM93UohkwWZB4dND/kC7Z1BeTE0ZxHTtOlG8Ck+Qpjv1NbwV7Nd1zMxYd/RswfwosxBBviIUIb1WpFAVFRaFfJYMS0CZDdvCU7aliB0QXIZPizbLHJ6jhDJiDJXryz6A6uIk+/Yx+TKjkhpCPDsEWbCSKF5NAh27XwKVXnNlsr1F9c9XK3X7cA/EYvcE+SGmenjSxTKOjtzohe/hBLnk+RM7tHDPIzbGM5+f3mjGHiCcuIA4GEu2gvVfSTwVI/UY6XIyQ58fP7KwvWv3klkKyAkaSjRaoEr6hicBQmwJlk6SsVPWa1shB5cohf16SP0u+Mgp7Q==
X-YMail-OSG: 0aavYDoVM1l7yhUSEhNFZPCxEwiBF4WpxcJ6iLCW3qpbM4e_FTEgE8cB.yKlaLX
 CY8EKcE99TELwLCMcJkWiGowzQblulM.ycaMY._hH7hsufkoyROIoVT2f4lrrI1nyyKApYK2yU7H
 dbxpx6nauptdIYzjck.nOAEsWIvHZ6K5zNgZhCtMUDX.dETXtAWEosXNhNsxQUutui7Ta7YnoQKR
 bg9M0djMT4fXRxgsmQINxRaUnHRkY08t8LzFpGuXDLzfGcQaV0FjaQVflpUlxuCGSdiW5hCv9khY
 F7Do_NB0qWiFcBXaleeN7ZuamCz3kUidCHttKJyXRhbDNpnXIWb0HrtPrlf47ZsnRXDEw4WpSU5y
 67hyHTIWU0hhUJA_zcWwGlChuaqJp6gM8gMJO21JR5dLXFycpBz1hSUQ2sIP.nzvJ9ZR3Ip9ttEq
 _lNokE004ebwnG0zwTyE_Ebx0gaR48RBUPLeWCHcoRkVz688x8SXg8XjXw3GYi8MDnj6TwOCzZ1e
 eiofWuJGDgQSEmV4GDLzCtMOiZzgxVuKTQZUaWoKr6SuJKc2Vv2354ZSuecp.6rFNYbJX8Yz94Cd
 YuFwbFPAvfkCXn8B0Jx.Gto0nI9PDHOA2eAdw9P_WxIiu6yP7UTKBPqxWjylHZso2jx9LFBnL33.
 UNrlEtfeY8Ws2o6TYFr_xceK88.4mXedtbb9wyZN7o64DN.QjslqiMq0YCqKfOjCFW1wdioSnLgF
 H.bISKuKrDCuE1ecmc9w_NcgP9QJ7iOvo.OK1KesAjWboZEbrWN2wHaC5dNINegxkh5eD8Sk0.2V
 CYqeKvnRji7V4ufeNF7fN4jCzz2bMAmmHLVCXitsRRQFlb_uyZ9Glnoyn78KGvhlGGV382FRESpC
 qNStH36y1_ISl5376pWkPZNCPADIn8K2uuRRRCAtjRDs5iVCdEgX3U2kg3UNQGKv9IpRC9abdDwF
 LrxApOsyMaDwibAsQ5sXkDEHfMqkhBwMHD3FquB5hpIlpFwmskaEti5Z_ilSccCzInEKXeBWb.Sc
 .9NuwGE511.F3lcKy0dVIQy8BjWJUdBdaYxwHVTl5qnvUavyvSj6VGOQxTaw8TUHBKkHFlhTMZcB
 ru64Kd0WCAiM2GCI.MWYOksFqdQEpkOK41kG9o8_vZV14_iH29G73uSXt1xFTrJ4FDXWOP2igSJ.
 kKGKZ5.W0zf70rR.paSmBBf_nEblpJPqtgsYozDiZNt2J3j9keTtsgrPFmIoAQsCGC7u2WnAUzSc
 Da8PFjDpbPVQw1UV4k6b4kpkC1GPWRNW_pz_FwOWAqEPfXwZ9buuptO22tjXevGtvcSBV38tu.9p
 Frg622DCu05ei9OtW8wrhiftjVJZXgqwfvBnduL9HezEN1fDQZ2Ynr6LOwiyf_NtxSEMUItMXEu5
 SbBKd.OZXIUQK6V2tG2XG9AT1cGEQ0G4pwyNvp4TXXnytT_OcHI0NGAhHDuoWos0JByq9F_WB_GN
 DxnVaKu4HIQ1Co60uh5ZUMZvS3WU23ULxoC9on3YF6Xg6iM.FyLEiqzB1NwLM8kQnI8OjPudLmh_
 yQI92co7rXRwzz4oqAQ.bayxvUwTnxJFJ0A_lv7UEMh5OVvPlUtgdj_LxyjZbuxnB9jgtGMSB.50
 h3qNAf3bgP8pEWTjkcztklLh3bhlq.eEU1t1ypsgm6EMZki2mby3tyvgQI0hA06biwfVBjKF824b
 RPaZftkPbQk.tE2j7t.q4fc8JFpnL16ldoxOXZ5013Z1lFHKTohNlTkvPqnqyt.HaG9LKIGIF1eO
 fztfr6M0qfBDz_xaDksuk9wQfnoiWuZLEeIe9zjv7XD2dlOA8FOYTjs5qaXLcpx9POgbE.k_kqrD
 6Lw0eLuiU0LkrIKz1qbjgE1YNV0ct5l1BXAc3.UmfTPfV4DpNV7edtyWo4aYtxUIfkkJwv8a4LsL
 XqfScdufhmIrNrNMkl3CcXgXoi1VjyaxOfFbaM0zQEVNjhMA18xP6zhQOkzmkYEkFkppl.UljSNd
 uL5jVi2.u97RXsOebv5i3ytFKpeEEeSUr0Wkhi81akSvCqFdMX6_4g2v3Fvgf6255Ysr4GiyiL9O
 .MXU39mR5mtLZKfhiaydOYCl9W20AhUb3L3f7F29pwEX0_GIX5WMezFK7KreEfgYRzZNM3vvjRpr
 Az_8DjkOQIXN.eEQPwxy5mkLoCQr5UBiMWWy0DbGswBNWirynbuQ7FS9W.glSI2GPHp.TuF2g2DR
 Sq0CKfW2smKybrKDrvLAt2lb5g1odjBrmHzKispfpq8GC0T6qXO8i1goeEjkrmVyWqaiK8c_uPnh
 RYzqppA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1e866130-6ed4-4a67-b91d-5b6148f7a9b7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 18 May 2023 00:01:55 +0000
Received: by hermes--production-gq1-6db989bfb-ppvpv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 367ad1d75e8e842bd35c1c2b18c48fb0;
          Thu, 18 May 2023 00:01:53 +0000 (UTC)
Message-ID: <bcf4df59-3915-6df3-027b-8cb35b310650@schaufler-ca.com>
Date:   Wed, 17 May 2023 17:01:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] capability: Introduce CAP_BLOCK_ADMIN
Content-Language: en-US
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Serge Hallyn <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Frederick Lawler <fred@cloudflare.com>,
        Jens Axboe <axboe@kernel.dk>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        louxiao.lx@alibaba-inc.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230511070520.72939-1-tianjia.zhang@linux.alibaba.com>
 <b645e195-7875-9fc3-a8de-6676dfe800b8@schaufler-ca.com>
 <e1242268-e7b6-d77c-a94f-edd913845ca7@linux.alibaba.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <e1242268-e7b6-d77c-a94f-edd913845ca7@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21471 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/2023 5:05 AM, Tianjia Zhang wrote:
> Hi Casey,
>
> On 5/12/23 12:17 AM, Casey Schaufler wrote:
>> On 5/11/2023 12:05 AM, Tianjia Zhang wrote:
>>> Separated fine-grained capability CAP_BLOCK_ADMIN from CAP_SYS_ADMIN.
>>> For backward compatibility, the CAP_BLOCK_ADMIN capability is included
>>> within CAP_SYS_ADMIN.
>>>
>>> Some database products rely on shared storage to complete the
>>> write-once-read-multiple and write-multiple-read-multiple functions.
>>> When HA occurs, they rely on the PR (Persistent Reservations) protocol
>>> provided by the storage layer to manage block device permissions to
>>> ensure data correctness.
>>>
>>> CAP_SYS_ADMIN is required in the PR protocol implementation of existing
>>> block devices in the Linux kernel, which has too many sensitive
>>> permissions, which may lead to risks such as container escape. The
>>> kernel needs to provide more fine-grained permission management like
>>> CAP_NET_ADMIN to avoid online products directly relying on root to run.
>>>
>>> CAP_BLOCK_ADMIN can also provide support for other block device
>>> operations that require CAP_SYS_ADMIN capabilities in the future,
>>> ensuring that applications run with least privilege.
>>
>> Can you demonstrate that there are cases where a program that needs
>> CAP_BLOCK_ADMIN does not also require CAP_SYS_ADMIN for other
>> operations?
>> How much of what's allowed by CAP_SYS_ADMIN would be allowed by
>> CAP_BLOCK_ADMIN? If use of a new capability is rare it's difficult to
>> justify.
>>
>
> For the previous non-container scenarios, the block device is a shared
> device, because the business-system generally operates the file system
> on the block. Therefore, directly operating the block device has a high
> probability of affecting other processes on the same host, and it is a
> reasonable requirement to need the CAP_SYS_ADMIN capability.
>
> But for a database running in a container scenario, especially a
> container scenario on the cloud, it is likely that a container
> exclusively occupies a block device. That is to say, for a container,
> its access to the block device will not affect other process, there is
> no need to obtain a higher CAP_SYS_ADMIN capability.

If I understand correctly, you're saying that the process that requires
CAP_BLOCK_ADMIN in the container won't also require CAP_SYS_ADMIN for
other operations.

That's good, but it isn't clear how a process on bare metal would
require CAP_SYS_ADMIN while the same process in a container wouldn't.

>
> For a file system similar to distributed write-once-read-many, it is
> necessary to ensure the correctness of recovery, then when recovery
> occurs, it is necessary to ensure that no inflighting-io is completed
> after recovery.
>
> This can be guaranteed by performing operations such as SCSI/NVME
> Persistent Reservations on block devices on the distributed file system.

Does your cloud based system always run "real" devices? My
understanding is that cloud based deployment usually uses
virtual machines and virtio or other simulated devices.
A container deployment in the cloud seems unlikely to be able
to take advantage of block administration. But I can't say
I know the specifics of your environment.

> Therefore, at present, it is only necessary to have the relevant
> permission support of the control command of such container-exclusive
> block devices.

This looks like an extremely special case in which breaking out
block management would make sense. 

>
> Kind regards,
> Tianjia
