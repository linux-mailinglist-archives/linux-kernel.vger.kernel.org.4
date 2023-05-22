Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B3170C600
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbjEVTOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbjEVTOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:14:04 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD26413E
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684782838; bh=5PjyTkGbxbWoXo6Jj97PelUNi3pZkd/MtnEWKRraqiY=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=dme2t2NnoEfdVkjrfM3UNuddSm11phCf6t7twSam/ek0nPQJOhqEMOvYCBAx8QcKNy9yXV8V4sjD4Qbtu6CD86bCK4hKHm22XkoYIzyscvJVeRrk8Kmmy1ZHXxxYXh375P0BAgYejwOSPP4U+XC+kx4TuutZahNfIkBERUN8RpX3gD/4641e92ViPi6csLHNxr9ucQQnU6ptLZGqV/QwI+RGnM/4yblXl3ElINi9okCV9HPK58m45pGrFqX4MJUMKvHDd2ggpRm+blS/qmvQRP8bWUjNmJ0UJx3Kls17pEPwU2XC4vC+KgbR0towVheCtb/WSx2RNmZ1wfSXjyHeIA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684782838; bh=WPQ1lDyeQ+HtkfX2mnGxyl9z49jcIlHZDcyA3bbp/OR=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=okdb2h2vfNi1LhhdiD8QKBnMBllGFK2wpKsxlMgkkbHkiBgByKzDSICWRFpmSGE7nsuEHsu27woJhQcrhVuxSrRomumV7TUqlkuL7bAbeT7EIGEENl9sMZ1Et1xov7luBhLR7rX8hLHINfh4CB55CYJKtK2IGzaTQ2kUlu+5jIbwc4Nn9nqPvIOjk3Wp6F0lSPgf2+g9VJ4aHOTFzQWyRovZ6/QsBZllv/NwwlaE5gkox0VCE997XJIbrwSyojriMRPiOPiDJHPd+ZLdxVlm+iOsLdLOiyTgaYota5W2XzodjQGTHW7uETxF1QMoozmLEHjL/0hlYSQfm8rCJJ4txQ==
X-YMail-OSG: 6zqnofYVM1lADttPYxGtAYC73.0nbVmyuvxR7HNQklGeqDQExaMsqcodRx_OwxD
 iXryZDIUVeOAilUUqn6sNbMjnZf.yeJicL5bF7Q8HRVOg1kzVSk8QbGxiEEAxNa8ZWGMmYXfN3mb
 tHA2YBqL.kioc76hcCQqaFHYcRQEuVG9yX1yC__VsEHQBKz1fld7XxOgTIrDqRp_j0lqM5Y5dyTf
 1yFLe.u7fyIpGVwDMoEW4A7ryOsO8ycZA2euXEs_473vXZiSh4rs0DBHnKaBjc0AbFJPzHHYwDcE
 0iLaw1SGxAtPqhz8Pop8gDAu4oe40CN9CefTzXheJ0aWqeNWMIyGxm9KB7fOBJFEPW0lkTE9QmMA
 It_vWmPaJ9NOIvmsrGcUhFls_MtSNb6wa10zbO3CLUZh9oeblmM48k7tlWo2yqMgir.WPM_Ij9Fn
 9qgnWC7Y9K.XdgVAg1QccBl8HwJml8G_HoNsJk53DPWt4G6kIAgyapc.Tc0Kew8A318ZasfszqHs
 Jsq8YfnoAwjv9Tu9yqrPzgN4ymFYcWb0VU.lce0HddfdfikEZeZimqUcRVi8yiBbrwiJyEA4cKCu
 GSOslD6psIpRhuJKqVhKpXYQW1cRdkhAu2PR2bdVDoRVOR0fkpUfu7pCz7kDIpfqWgnLw06HOWuL
 0.y3YOTPzFcu0E0lbfcNMh5v3MG5O1FoBRFE8UK4nTDj.k7IqIbRRTw32GStBscRdwXpMTySa4PV
 yi8MZoO7Dv0NmhDzkwXNhq1v3pIkztI1Q3uBAoea6yiUBNW8eGaxCFYbNLjzR7xpS8UO1pEQnwjS
 o9JaE4fAODBEtuSrQnW7mXXQ2tUxrthxD9qe33n1PAzB.zxINCtmSKA51q8qNC4tMEdJsCqejzyK
 OZuMCpfWixg1_h7C6FetXnX7RYF84L5GTgRCWxPk.pbsmo0gFSyP9lxPsQH0yao7PGArLsKPhWIM
 nWfthpEls_9wkxnSQfnvzTwdmUuz5O5R.WmWQdNAKv3.PNsY.ZQTzrPdRDTykNpw1ZVhWF0rKY_P
 CFeODC5JGrEeDRpd2BVFJ6VKaMAqCxTUH6Hk4g1TjUwFfDPedq0.uHayufd7nDUMHy_PuA1khK58
 mGfHLccRGP8fEgxBykd1GQuP8ZvTuq19.slUuFVn_E7900fHwh6j5Ui1NbmvW2StbjWQybNnNOd_
 6aSTdV05IHv6Yxk0TWuDx4uk9VonJINRAPOrHCCIFpTFzZafsUAoUT7vhi31MR34MnKmFAKAyb_h
 IYCeJrdCZtPdCkMExWIYVv2Jdz_MICldZWFvI6DfmP9jzotE8EgwzHixwC4fCgYhGVVv2BKgwXLj
 Tu63bPYqBrA5cPh8YM1_E.92lS4n3v60fwO0QPH30vivv5CNfkduASZGCRR5UjNxlcpgxBCTmQAu
 w_KCyVvEROx4EWmiCmU8L8.cCHQLNaJbMdV.BnegO1gnkti0LooCCVEsaZTsXSIEkmV8niFLAYPg
 t8Te9XKmUVl7akyyCE0Cjsmr1EeGjcTW1XkJJQKgUEe21S0GjTYJeRsiasrTWdrJjEEEMx.hm64A
 e7IMePMLQktQFpotKAeEJe5EWPxaRgPEK87to4ntC1iabedrOCFpO.tn6UKyKpkFg3AGGJAixA9A
 _E.cQVPCjr3PDgerhMiwj.RjJgNbN4eUzT8CuoRC859gWRfYVQ_WVEJefNJhJVmNOXQw.v5NowQt
 DLAsNqjrcLOoOpMMW78qW5MEUNwT5_9Nd6a7tE_d5pbT3Co32QjeXufuwJa0aM36bA4U2XeLnUmk
 laduUtHsS_SOWzrmhbi8s8PHu74vNsWwJ13gHdsU9deyvr6heQdK_IR5TtidfgZ4Fpy_y7tjHm51
 vswibEj_rp0Z78ipAAyw5mPAN6Tv81qG4.XWTC.s8B50JfqsjfIXEVqsin0kAdS30YbRAOWq7ios
 DxfrHSUtLk8ZtEkib1rGFL.OGgTdG0i_4ncOTzq3plyaLXwElm0cGzDngvWxePy4Rf0sH9z1wovX
 2tvitH3dS_F4bXFhhiWXxJfxW8XxMHKmuTl7apgtg2Q29limdi.GTTvXZlC.Ze619uOgM_7xKiFa
 0PfZdJBqXixjygUNA7wtGIlzybv3VjTuQieDH6oGGkU5tuxK5oNYPNdEZyZZdNt6aJufoJyBh3ET
 nuXGfdkfUhfIsL5nda4sdy_Q_JXvnir_UMdNzCtLDl3U3WZ_.ZXxhvUmNZ96ujDDQjbORVQFf1lJ
 0nR79k5KdhArkyJXp_S7UvJV8Q34X7_FDWn6ixOSKPXl12YiMe3Ksz4oTLaieYj.MnBlS.95z6UY
 VbH0-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a61b352a-41da-4108-a0bb-21ce5241803b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Mon, 22 May 2023 19:13:58 +0000
Received: by hermes--production-gq1-6db989bfb-dbflh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8599ae451d0790b8df20e401e458654e;
          Mon, 22 May 2023 19:13:54 +0000 (UTC)
Message-ID: <bcf38ded-f1da-2fe4-c6a5-195c9d46718b@schaufler-ca.com>
Date:   Mon, 22 May 2023 12:13:52 -0700
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
 <bcf4df59-3915-6df3-027b-8cb35b310650@schaufler-ca.com>
 <345a7cdc-e55b-7aaa-43d4-59b3f911ef18@linux.alibaba.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <345a7cdc-e55b-7aaa-43d4-59b3f911ef18@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21495 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/2023 7:53 PM, Tianjia Zhang wrote:
> Hi Casey,
>
> On 5/18/23 8:01 AM, Casey Schaufler wrote:
>> On 5/16/2023 5:05 AM, Tianjia Zhang wrote:
>>> Hi Casey,
>>>
>>> On 5/12/23 12:17 AM, Casey Schaufler wrote:
>>>> On 5/11/2023 12:05 AM, Tianjia Zhang wrote:
>>>>> Separated fine-grained capability CAP_BLOCK_ADMIN from CAP_SYS_ADMIN.
>>>>> For backward compatibility, the CAP_BLOCK_ADMIN capability is
>>>>> included
>>>>> within CAP_SYS_ADMIN.
>>>>>
>>>>> Some database products rely on shared storage to complete the
>>>>> write-once-read-multiple and write-multiple-read-multiple functions.
>>>>> When HA occurs, they rely on the PR (Persistent Reservations)
>>>>> protocol
>>>>> provided by the storage layer to manage block device permissions to
>>>>> ensure data correctness.
>>>>>
>>>>> CAP_SYS_ADMIN is required in the PR protocol implementation of
>>>>> existing
>>>>> block devices in the Linux kernel, which has too many sensitive
>>>>> permissions, which may lead to risks such as container escape. The
>>>>> kernel needs to provide more fine-grained permission management like
>>>>> CAP_NET_ADMIN to avoid online products directly relying on root to
>>>>> run.
>>>>>
>>>>> CAP_BLOCK_ADMIN can also provide support for other block device
>>>>> operations that require CAP_SYS_ADMIN capabilities in the future,
>>>>> ensuring that applications run with least privilege.
>>>>
>>>> Can you demonstrate that there are cases where a program that needs
>>>> CAP_BLOCK_ADMIN does not also require CAP_SYS_ADMIN for other
>>>> operations?
>>>> How much of what's allowed by CAP_SYS_ADMIN would be allowed by
>>>> CAP_BLOCK_ADMIN? If use of a new capability is rare it's difficult to
>>>> justify.
>>>>
>>>
>>> For the previous non-container scenarios, the block device is a shared
>>> device, because the business-system generally operates the file system
>>> on the block. Therefore, directly operating the block device has a high
>>> probability of affecting other processes on the same host, and it is a
>>> reasonable requirement to need the CAP_SYS_ADMIN capability.
>>>
>>> But for a database running in a container scenario, especially a
>>> container scenario on the cloud, it is likely that a container
>>> exclusively occupies a block device. That is to say, for a container,
>>> its access to the block device will not affect other process, there is
>>> no need to obtain a higher CAP_SYS_ADMIN capability.
>>
>> If I understand correctly, you're saying that the process that requires
>> CAP_BLOCK_ADMIN in the container won't also require CAP_SYS_ADMIN for
>> other operations.
>>
>> That's good, but it isn't clear how a process on bare metal would
>> require CAP_SYS_ADMIN while the same process in a container wouldn't.
>>
>>>
>>> For a file system similar to distributed write-once-read-many, it is
>>> necessary to ensure the correctness of recovery, then when recovery
>>> occurs, it is necessary to ensure that no inflighting-io is completed
>>> after recovery.
>>>
>>> This can be guaranteed by performing operations such as SCSI/NVME
>>> Persistent Reservations on block devices on the distributed file
>>> system.
>>
>> Does your cloud based system always run "real" devices? My
>> understanding is that cloud based deployment usually uses
>> virtual machines and virtio or other simulated devices.
>> A container deployment in the cloud seems unlikely to be able
>> to take advantage of block administration. But I can't say
>> I know the specifics of your environment.
>>
>>> Therefore, at present, it is only necessary to have the relevant
>>> permission support of the control command of such container-exclusive
>>> block devices.
>>
>> This looks like an extremely special case in which breaking out
>> block management would make sense.
>>
> Our scenario is like this. In simply terms, a distributed database has
> a read-write instance and one or more read-only instances. Each instance
> runs in an isolated container. All containers share the same block
> device.
>
> In addition to the database instance, there is also a control program
> running on the control plane in the container. The database ensures
> the correctness of the data through the PR (Persistent Reservations)
> of the block device. This operation is also the only operation in the
> container that requires CAP_SYS_ADMIN privileges.
>
> This system as a whole, whether it is running on VM or bare metal, the
> difference is not big.
>
> In order to support the PR of block devices, we need to grant
> CAP_SYS_ADMIN permissions to the container, which not only greatly
> increases the risk of container escape, but also makes us have to
> carefully configure the permissions of the container. Many container
> escapes that have occurred are also caused by these reasons.
>
> This is essentially a problem of permission isolation. We hope to
> share the smallest possible permissions from CAP_SYS_ADMIN to support
> necessary operations, and avoid providing CAP_SYS_ADMIN permissions
> to containers as much as possible.

Your use case is interesting, but not compelling. While you may have
come up with a specific case where you can completely break CAP_BLOCK_ADMIN
out from CAP_SYS_ADMIN, it's hardly general.

>
> Kind regards,
> Tianjia
>
