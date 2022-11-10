Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6D662388E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiKJBDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKJBDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:03:45 -0500
Received: from sonic313-16.consmr.mail.ne1.yahoo.com (sonic313-16.consmr.mail.ne1.yahoo.com [66.163.185.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C0C15735
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 17:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668042224; bh=XOgMVQofTlzmqF6zrzEYVKmjdr4APelMVuK/ykKUmy4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=GE24KiS9gmy4fDstJB8kHRrKFTEZNCpj9ogdjvhRyahsvPTjUsc7fVv5cDyyxyjGDaQ9dX85OZnjoYMlPiWb/BvueQSm4CftK9Js/mqVfe1FpN9cWP+AoiiPcu1CnDXsl8L2QErhe5WQirZw8+iv2FI88lVIF7JoQ0FH164FRdmlcdxqnIVD8mPvbUixeSZPXDexBQLDaxOcFe3P4Q5qp+yKdYhLaak3lhNdBa9eYKN9+XatbOaWC5md3m9+DoJ5atwMMAfBT2D43jDFQFq48fTIdBVuQzpNgD4JjUbG2NGL3GyBwBE8Ua42KITj5CZ9ccLydKInImYGZYdBQGd72g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668042224; bh=jmYwe1sTeQ8o+MAPqJ9Gsm9nvG/pFc2Y/W/f9Rn2O+P=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=jDkhRvPEZTHYvgKlbl4R6Ms/GNBWkvSYeVtE0ZNWq2hHaQq/w8O1NYVdmM78Zt/t7+mSaSWkQXONNAj7hYb/70s+mInm9N0kZUwOJO4uGZa8H7F1jq3+ueer+XmUVq5J9R0sGX4/q279qvoBEQk1Ly+eRIWH7zKkTKg/bNiiqujTLy6UzcE2InIOCQrA+xNwGZAbv41rDtJm61kx9izQ4xJTEhCHm7s+7Zh6cPKCDrcTm1wduVf4NEFtBJvgSN5asEeBbp7mtL+KbJDWEYskGTAr5zCLXgijKncqhwWseFF4v6VFaEWYYRiYc/PNkd1GdVAs3XZF0lovllPiDRxAqw==
X-YMail-OSG: HgfIoksVM1nnx7HWAkUrHdryitHVM3C_ZxVfLBGjbAa1p27CHQ3GGI1NtWt0BPQ
 DgI5cWgSDruzLC7wNvojkWKnclUS3DWebxS3rNhr3zIsdjj.qktMZwEHNm9fLYBLALedT9ma.MHI
 Qipf9PKM8iQH.njDgp1ZsGRd_VZ5y.p0HBm3aKVpWpHvo7F3Zk7778hAHUZ1UX5IkdkUha2osmAv
 NPBUmYsCaUfz8LH547dtEOBtFbJMQQUSRrHiAajeN7iZMMEKMTw0yjxK9Oz2Y4YZq30.pSCEvMhA
 KmxTFXu1m_OFLASeJP5slLMBUHumItJQRlmbk5iCAI4XcGeJimEx3VaGbFn_hyH0JmCWStRXM3.a
 Vx_LzxrrDNE4alrI4PfkCIYeplCtexhYGlycDDgOF.fxP_bdGpPK94bcVcGnin4e.LOMxuCNK0ac
 by4vmiBZOR5Mx9ViIFg7AU_AMozyXZRGmWBvc8JSNhniq82ACIBIt6qpd1rbPQA3RFApbLnSFaxg
 tcMjKm0Lr8GukA77LVM.JA04N2KuB3z6t7.chyJpkMokFd4BxFy.ue0jx.iM4eLg7m8maJKyxO5j
 1RvmUlbclf4Ib4Eayi3xawzoRYIP_D_G1NBo5KWrZHqb4VMqTuJLBh_rUbc2vPhxE8jy1Im2cO4d
 1XHBEBBe4pZtvso50Q.Y90EwkaJ.cg2sBldVGlzA084pKg3eKT8GI1ki_qwbG_BsS303FsYIT8_N
 NrbVCzswo5UzUmlt4A58O_TwuXSBo5FGvYYYcA3V6jJBXHylHAXGvBytwnngEy_JmOVVvLwQgAOY
 Yu2UGKvmwgdGJgnOZG3rIaILRpBLIgPhjsNATlbLDYZexhK8BDlxGIBr6w8qQTBPtmrFc3OeRQIU
 9Jiv4tMOWAJ1NEbVtSLKoa1AR5IqL70M_poMm3x2jRfmurO9iRpMAVLvEGP4inPHEilJjuMTPL.d
 4uJkhKMDuud3zPHfKSFSXdERKT2gTZCAiWH5VOTmDnr_.1hutNZPrKlmPzF1IhUspPgug769EtGc
 6nx4dKxqsskzVRrJBhMZuAk40duKDfOZm8s.E0ezWHIymbd3twVGkQ2S1hKX0n.9_OHqBQ1IjsZ4
 GTKLf_IbDw1kv1vu7rd3QaNqyBXoI4wx58he4UPqPIT0wAyLHRbtmd59m_3qac.qlOZ0Xve7oZtq
 ti_eePoKDCqW8sWtL0VYLdetfyQ5hipSBFJBLXkhm2XJRIxuX_YfI7IrJpVY73nvc5tsVng_XF56
 Zg_W7SCjEeKtnFmUZNOnknp41LzA41s6fZTz7sipYKAlCygR26tuaHjaDfwlohGxkGKkHkK.ZHN.
 Q6aF1pVO__40xDJifWCjoU5GYQHB8zh0hP7z37oR.Pb9g2dIlpU3c6UoI.ApuJcyxVtcvAgQWuoB
 VM6MhW.GPatleAWOYxBSLD7OwgxXA8IlRPfiDRxDPcW_0HNVI5wTXKCyMymWZ4cyMD9vGTcB2roL
 6oHr4XcwUgrVSNeXPZltz7ZwRroyxatP42QHYwptiub8N5E2Ia00ybqcOZjaDuMJC5WI522mZIQa
 CLgTjXGPUb6riCTT4sCpPGhiD6eJQFELNPsO8XY5kvS1uhhjIMqi5I_jOFeGO_RVoZuyPIWrCxGC
 soS4FvYBAjV0gDMIMSyojiX8irzjgqhuaR_.byLJp4sEFugc1r7yRN2wXuNeAShDYnkCFeQ6LVMp
 EymbMuQbdxx8.KQwW2PN1mwhxirgn4_SVnM49oqazKTw.ztWxEQjRFmD.VB_j.u3XHq8fwGmCBqz
 HRpyOlVv8RZTO.OQKjPzL3eeEFYqmzzx_v7qsgH9SjH8nfUartdESxtFF6nhk7W29uVDTYnHLFbC
 lwQYL5n8nd7arYpeAQQo84Sr0UiqZAfcTyxR5a9ejja2.oKnnoGIrjdGKJ.L0elstTyOWDH6xfsv
 1INgCKOQUeJ7iPKXmScrCRljgzoXjYN75YxPHwzF43NOPd8NqFPZOvEE4E.REqF8hL1YlTUq.V04
 qLb_Dq1JeB3i7462VJwpm8mW4RpGQuZ8MVgoZGXOOLgNk1zpMbKA_YIhzNBKBsJgIMHbqCUJK_po
 Q3BeDMcWpWR4r2XrZeeV7I_.5FUp82OMlYTKG4DKE8WNS76Oy74tffAN8xF__3cVnsxdmCmun3XF
 SPytPlpaCNshdsGzTAWFYZ6jRI9M4_UfGDgGU7cnGvHA6nDYJmJxCciiGKzt7w8uwyNKp_g8.m1Y
 ZU7d1IN9gcNDg7Bnf1cXz5lzPYPee
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 10 Nov 2022 01:03:44 +0000
Received: by hermes--production-bf1-5878955b5f-686fw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d6bd453e1fdc26cedccf22e27d046a7e;
          Thu, 10 Nov 2022 01:03:42 +0000 (UTC)
Message-ID: <1f595d0a-07cd-365d-ef36-8d796b783f22@schaufler-ca.com>
Date:   Wed, 9 Nov 2022 17:03:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 3/8] LSM: Identify the process attributes for each
 module
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net, casey@schaufler-ca.com
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-4-casey@schaufler-ca.com>
 <CAHC9VhRv2biawm1w=8sR=DMBhy8FLNwxRch13j4EUBkCRUpxrA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhRv2biawm1w=8sR=DMBhy8FLNwxRch13j4EUBkCRUpxrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20826 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/2022 3:34 PM, Paul Moore wrote:
> On Tue, Oct 25, 2022 at 2:47 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Add an integer member "features" to the struct lsm_id which
>> identifies the API related data associated with each security
>> module. The initial set of features maps to information that
>> has traditionaly been available in /proc/self/attr.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/lsm_hooks.h  |  1 +
>>  include/uapi/linux/lsm.h   | 14 ++++++++++++++
>>  security/apparmor/lsm.c    |  1 +
>>  security/selinux/hooks.c   |  2 ++
>>  security/smack/smack_lsm.c |  1 +
>>  5 files changed, 19 insertions(+)
> Everything Greg already said with one additional comment below.
>
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index dd4b4d95a172..46b2aa6a677e 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -1608,6 +1608,7 @@ struct security_hook_heads {
>>  struct lsm_id {
>>         const char      *lsm;           /* Name of the LSM */
>>         int             id;             /* LSM ID */
>> +       int             features;       /* Set of LSM features */
> I understand why you called the field "features", but I worry it is a
> bit too generic for 32-bits of flags. Let's make it specific to the
> LSM label attributes; how about 'feat_attr', 'sup_attr', or something
> along those lines?

How about 'attrs_used'? I'm open to anything except 'late_for_dinner' :) 

> --
> paul-moore.com
