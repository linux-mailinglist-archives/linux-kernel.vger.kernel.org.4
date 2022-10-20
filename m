Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE54C606C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 01:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJTXmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 19:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJTXmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 19:42:11 -0400
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD5116D88B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 16:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666309330; bh=Ct7M+eQn+1sXkf2JlGtv/zGo5O7AhhVZoEOq681KO4I=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=XJmUiW6rhdzJKiAexE8m1tQxbk48VjkEUm5BKgiMF0LDJwCzYhGksG6Ph/Vdwdauh8YnUKWkeft8gmdi5LpJWTI54eoIh/fmsKzfiegtPKwRBhVqM33qGslEPkmnSpqYSUgyiEVCMQYNp9P88PnCibZ18JKag5brlfvESSROreN39oQCLd97gbpie8GtPrETi96vkN7QOdpKAjld6s6eRGs8NGV0px5a3LPYuewGPfUnOG0SZDK2CZW7f8g7+yFbovIEp5u7xNzepLRblAIGded2lUOp2sKKzOGOpmfjy0G23Lgv3ki8blkg8P0VgMd20EqH61ubYZL4hQMucCCGlg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666309330; bh=R/3JbMN9lfHknive0qn6sbuvnm/GqGh1VGmM3zN3yJx=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=USX4h9tBzG978n0IM+oZbuWrsq0Fq0YGj2pRgqivqvsD7jTODfUq5EOK5lLVEb2RHuClTEeArF/1kydv1BreD2lJkBlvgW9bmZs2rZmHyWq4IgEzFSZrxFHu1bM5HimkxYRkhuRlJjzDrp4oyebm+Y6LSE5oNyPnD66zmMDXhZC31kWZDLH2BM9GIsXCv5jVllfUw6tU1B8yf1ER4vxia2y21tFTpGcfY6rJzrKpLsHKA+gWYFF4/ZVkZnqIhW7SPcjYp4IovL9GmT5PacArUy+4dhbGjrY1jD7Kil1NA0O77nSr81QIq9Syhw4My//+WW3XqtQg0ohCDjYCHQ0xnQ==
X-YMail-OSG: IEVbw1YVM1lqZ_LzZ4UpMqXtNV8WoDJX7Eo0kYY34UcqisNoIH7LsWa_7kS6vnJ
 1v7CZXjW_noROX74Oc.w.avDj6ZVVh08Iuh6cOLfHW5uONl_vHl18kyz5LOQHwUx5AXyMVs2SxrN
 zurVxX73AvlCx2kQ5o_xhebjWspBMU.wvJFCprW_eU4Rp4Omyxz3jkknsQWBbWk1WR9HhMs9yDHL
 FaL_u5a69D36cm0URE663LbZeE4reCck0MJTbr8DY_.6RdwBL2FPOQregk_eFC3uMPkO2kDtWnxb
 C.81bYAwMnLRjzeVFgSPkHd9DjWApq1d1t2BC6xeZfjHk_4J74vPh_6jrgVNjXRp5j8ArHbMgFVq
 tYDsWjz6Uw_nUBkVT7I7Jal.5PJiw9qHrBxzueMz8yjahT2PnBw3pp1nP.Aw23DvSOH1wtZElZCD
 e7Mpyx0x4rSt_HIqep15dXJTl3vdECaW5psSxy0lRtkovIPsjDldkctv7EV7XrPcvvD4.A48ylEE
 6.S8w.8r0bP1UNd8Y77SbTh2Jr2Yk8o3_o51RjI5VA9JY2ktBxDO.C5KqSvAUKu2o1HXpwZeMmj0
 sJm4o0B3bxjTnqRjP5uRU_mfFeKgyir1Hw2cBm.SRmS0BpmteZt6oNoZ1l7OGwQ3JjR3RjKp5S3G
 .RBMhFRaZMV6xxJ6ssn16OdBKrNU.cffDPX4Wb6PkiX37T4xoDYL9dtXe877u6P857x.7vIpXAN8
 FJNR5hhSJzzD_8NxuFk125tSYkBSHqRT7sbJQMguklqorvlkXLV1V7D.o6YPnFWnX7EF4vR2h6qL
 2vb52qWjpADv3sQO2Il0Q8nwItyMQLQCe0wdull889uPzGw27VPanmxtPP9ZlTKYGQfmHSUGwlDU
 .1YnnYMmYT2BC5QWXKzwfzZPMyfgIPzl3JWFpH903PhHJlB1BQOfKyA90vynkdgFzaRfLUQuGb3p
 Eb8_5ddCHwpm_ZHestGVeFCUvBcInvS5ZaHLPFzv5zY9drjwXJLDMyeQYfV8TULpXyWHPsAO3Rmw
 M3iLX37ttXbZpHkp0ekEWJm3ItuljeZcBVqrsqaMVL9lWNlq4v.n2BHjMNd.6PeVSf_MsTe9Hhse
 GAQdGrlvp.qzgFYy0MoGIe4mJ8PkaPTeJuM.GxWREVgg7v_SiEGheBbIdzfvW1EBaUE9CqpCfD5Z
 WUZBF3gBWfyE6tfC1VssSya2ffniydcojldekWjESaXTJAFfqcU1eZ0zj0A86auSTNw4VkWp.Kjn
 fcdQM08uvckp3JSZAiB04ihWoh1ifZdMgoAc4BwOGbAH9uAn8iIpUPrQRYF6.O.4aImRB563Gv0S
 1nZT2iS9G7yWTnd0jkihlybpE5iX2o1is8plx5JXAuJy1fVTa1NeEn6gcpPnH.gDR6M1TYK90w9s
 ehEZFcyTUP.Atuk79MhnzPN36R640i4_vyIwUVCbOxb9YOTNEpjtfjN2pLtDNmOp0IyVmELllOtJ
 RQRaTdTO70dWiNPePFjHtyOAl0GqWqdE_TnlUk37R26bSJbPz7cbQhCh46g0.sBxDXgtLU6ULICd
 1gkha6UYzrABVvSQ1WDbMfDh9jqBXXMqPQxVqZIXJB29Z.aIjLx3A7HOijwc6IVVC9vmL8nOATLL
 .KKA2YdOnricxCn2sZVddy5npYD4D5.CGhu1IasCD5UOty3Sw5ZnOgZGVzOUwWOSPiUmVmPIY08s
 m63wfOx0vYpRWThNLdkMPjsZKOcIcKEyGLCY8UfwQBTOEpbqaOh_tQ9dCfNLZLiPgtlBZsMaUwo5
 ts7I.1Hu1PuhyRC8.Qx2YVQ6XgzLHAW_qMUfWo3vAtVx2MGn.ZGuZxDlp3NtHuXamddBZ52Bn7vy
 lSDexgoTbeQs27cXCH..iPyQ_ohzm3toYVsHhTJrSquyaVOizVZMfVSKBV5dR780gl0oyuJ9PBTt
 xdSYIcYDk.Zb5izX66yviyp_qEA8bhoCvZveS1VOE4bkDKR2gspCmqwaT1sgzsZNYp9m3FG4oo4Q
 wHzXBp93nwsTm.db.XaM3j.aGo7cUdd9t.2qznPibUJ_TAuOpBXoFt1u6O1.2ig6xuOPZy8MR6wO
 .izm4OucPFTgvQs0QiQ5VabmxsmG04gSbMcEFmYaG0LSB7TFLVdYFJcrd1wshEeMjzA8emfEVznO
 su9wL_1AQecPOq0wURE3Wl_NybfEzYF3fDucgH65KxtvPAamO2CMzRx..TX6iRYqSzRDTbtj2MkF
 ctQsiLxj468ZglNhHSt6YULzV0P7XVS5L78bSwLGAV78d97ZiyZp3K5XHaQeK02l.EXJDcXaKb8o
 NAkBdmGver.07NSEWahbM0rFT.Ce..w--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Oct 2022 23:42:10 +0000
Received: by hermes--production-gq1-754cb59848-nlbwv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 96be409d95bde475d58f7a617539a8b3;
          Thu, 20 Oct 2022 23:42:06 +0000 (UTC)
Message-ID: <f6b8ac05-6900-f57d-0daf-02d5ae53bc47@schaufler-ca.com>
Date:   Thu, 20 Oct 2022 16:42:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v38 04/39] LSM: Maintain a table of LSM attribute data
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     linux-audit@redhat.com, jmorris@namei.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        casey@schaufler-ca.com
References: <20220927195421.14713-1-casey@schaufler-ca.com>
 <20220927195421.14713-5-casey@schaufler-ca.com>
 <9907d724-4668-cd50-7454-1a8ca86542b0@I-love.SAKURA.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <9907d724-4668-cd50-7454-1a8ca86542b0@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20754 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/2022 3:04 AM, Tetsuo Handa wrote:
> On 2022/09/28 4:53, Casey Schaufler wrote:
>> @@ -483,6 +491,16 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>>  {
>>  	int i;
>>  
>> +	/*
>> +	 * A security module may call security_add_hooks() more
>> +	 * than once. Landlock is one such case.
>> +	 */
>> +	if (lsm_id == 0 || lsm_idlist[lsm_id - 1] != lsmid)
>> +		lsm_idlist[lsm_id++] = lsmid;
>> +
>> +	if (lsm_id > LSMID_ENTRIES)
>> +		panic("%s Too many LSMs registered.\n", __func__);
> I'm not happy with LSMID_ENTRIES. This is a way towards forever forbidding LKM-based LSMs.

I don't see any way given the locking issues that we're ever going to
mix built in security modules and loaded security modules on the same
hook lists. The SELinux module deletion code is sufficiently scary that
it is being removed. That does not mean that I think loadable modules
are impossible, I think it means that their management is going to have
to be separate, the same way the BPF programs are handled. The only way
that I see a unified hook list is for all the LSMs to be implemented as
loadable modules, and I can't see that happening in my lifetime.

I can see an LSM like BPF, as I mentioned before, that manages loaded
modules. Over the years I've seen several designs that might work. I'm
encouraged (and not a little bit frightened) by the success of the BPF
work.

Converting the array[LSMID_ENTRIES] implementation to a hlist like the
hooks have used would not be that big a project and I don't see that
making such a change would be a show-stopper for implementing loadable
modules. I think that a lot of other issues would be more significant.

I will, on the other hand, listen to compelling arguments. It is not the
intention of this code to lock out loadable modules. If I thought it would
I would not have proposed it.

> I'm fine with using UAPI-visible constants for switching /proc/ files.
> But TOMOYO does not need such constant because TOMOYO does not use /proc/ files.
>
> Also, lsm_self_attr() will be limited for LSM modules which use /proc/ files, and
> therefore I think prctl() will be already there.

While the proposed set of attributes map to those in /proc/.../attr there is
no reason to assume they will be limited to those. I can see providing several
of the Smack attributes currently manipulated in smackfs, such as relabel-self.
If we are providing SELinux specific values like keycreate there's no reason
we can't provide Smack or TOMOYO specific values as well.

>
>> +
>>  	for (i = 0; i < count; i++) {
>>  		hooks[i].lsmid = lsmid;
>>  		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
