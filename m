Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DB5623860
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 01:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiKJArA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 19:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiKJAqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:46:54 -0500
Received: from sonic310-31.consmr.mail.ne1.yahoo.com (sonic310-31.consmr.mail.ne1.yahoo.com [66.163.186.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2595D11C1F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 16:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668041212; bh=NWxJETnwXYjxKfg4fLafZHWiwPHR0jx6GnpdSyGD2Ic=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=BwYwGeSiOQ4dC0HPYGXtriJMBWusJiz6MSezClRE3meWveMOtyBxOfby0cd2etR1rjIaAvnMPggBs/ibmij0hL/7vU+gRtzKmmSTnWKBuequtSpGu7mSY+ciUe1BiYPPXmFYhKryy6d3jcDgUpQ6pjzbTWz55oULtTD1rlzPQrPZp5hNYWRlkpDjC6rIU2zfE5m8FeXR7Oc5irHNqys14JsKe5lwSC69Q9RL0uznaYzruXqfp72pongth60rqv2vRk44DCtwfYJDew3vN97O7DGF45c+rnGZ5xfF5C3e0/k3vYcipibB+JQKoSeXLTabFa553sUX7guivI3whjcXLg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668041212; bh=03dG7kZZ5H0uOusCmpH63c1g+z/CKS7yXQKFDoJvTTE=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=sSfq4abDkq9HvmACBFXuDUt6RUIxXGmHxTfpXRxgoM64NDSkqJtEDQeij9TT1E3l60TmDmnYt+3xDYYLEqaUdb3X11gK5leQUhmos7l2q4EnrjCPepkHdiKpixz878Px1FVPZq+mETjwTKKyBdQ/LnAayHxFWRFrrchBuFkcQufK4hJsH9XaLmdnLc2VqKNF9PqKNMJeKMejXLoCVRjRgskiNlJ1bXUrZKhTPB96vSVFPqjcDOb1iLMEhbY+Bje05b09MrMBXn7xe0RP+njJpR3IgcH6rRnu5/VN9IbMIUgGX/T825A4Cirin1E+PJicU+hRAb+vkK3sNGaRasKvSQ==
X-YMail-OSG: yWgdWOMVM1kC6vUVU814MJjOpthQToDLQgPI4iW2iDcii6Ou5PoVG7k0F7VoyZo
 VlS1QQEht7uY6u_KABXjW_dy4FzlQhK5CY3d0BpYP6vW_sG12Z2GcHy33hbKVJhdMJXJlqvk9vCa
 XTW7ajzLKyO1HqqwJrT7.r41dW485BhJj6sQALG7m6IJyoaKcnlg4wO4J84LOgGnTjplmo9WTnQa
 iHYYnmEh5VpKPghkd6r5digtS4doUehpS7zL1qmcS6Nug1pKZrHtnwAnzuSjpFV8jO1HakXq_p0Z
 XLF26SbzBznQorj_bAJ4CszxIKPnNjwg6XEz7TFBUeZHBTuvib2jC6pQkhUOTNsmkgRioHSWJwbv
 wzhVgDZhanxk5fWASNb1b4Je5K1SbQb.hgoVCLtB1ltCFAEa59PAfTUm7Ibbh5w4vTKHoGVuPewj
 Fe.GcpkCNUxVKy_Q5oKTojv9BEDXVARM4yhy.B19LOfe_X.4Tg7bXADqb5DIPG9hcmNNZgxPg5cH
 4Acx5u1fGsuH3VBq5ed.mcsswTI2tKMpaYyyrJOT4a6s8.Y23sGcZ5st_GZXmLgJgi7U.ad30Hsf
 91GNsAuKtXead0oqKGRgyzI1cp3z97for.V1nnyLZJatlC6r6s8rfPT0OfdmiypI8BIlY6RlRtVH
 xmNDbHbxJFlOzCcyUijqL66w_f3cYPR486zSrkTECqL1PcRR7Djo_8I4BIlBqtPpc5qB2Pe907oC
 7Z4qtzgeVBZ6u_pK2GvCR48J7qfl9GdWTsUFeH9ZJLOIhGQyUjbJScpKBt_T.4zSea8urMQCXo1i
 HZnw.ZCLV8IredvmNKsiHiu2EdT0.0tNKjFMpvohJlTqX4O8_mI8z.zSKTvRbCN.QP_Qo8fPkRDJ
 AMryCmzkoF7W1rXsx81pfRUA29sPYtvCBQw3V9o4hURbEliTVgHq8YNPtuXtM1YOLXf3JbI6w41g
 GO2xcQ7cDwlIdkAZ9IMWYGFgShTRnxFFN53kPWIOwvu9JYwCnPhwLtT.hlS8JlhOuY1sRmySunow
 Tco5Bw1o3FrYJaq4TqnpmCDKOLGtjDVVkVfCQq6Km9X9NOnTrk6PFBOPXASPoFE9WSM2KdxY6VXs
 VClpfafCyBjhhMiGtNidFd0GjxWQk10glcFNdBWqxI5LxvaAIX.vU_7d1jGSKGnZcR0.GUS1vna3
 HmTIyM36IvP5iUre_qiGcw2K6e7llHQB9oRLBSXmqIzqzw0HaOcJec3Bp5z62TrpFYfciCD4J.QV
 ym4yoNdqbfK93aZ70kTMuLfTZHT25e1Etq2dHwBJiSsdwAPc_Z8Bs73fXflSRcwbDq9_sAeUZwO0
 SY2vrvU8gjSoMxPpR6T8tou1KKbrnLFmxAifxQMe61mQwQdagHHt.Y.JAB5z7xxbfeIcE4HsBUtg
 YI_0MHKJRm9sHedwq5isKQRIAOvqAenFFvJxysWkzTO9WEBzps7okAXnPB8fUTvyJ_92JW7BaHgD
 HriMFgs8vEicKPUZ.I1KiadH40bSsmkIKabU2B_cLOynzwbNeaAKA36cjWuzsLURHufvauAh35Ze
 2.PeZhWykvbSv0XZlZ7ZYBHyJexW1RKOeo_dHieHAjyZx8xy9lgmCFwIC9C0nAr189uyDtYSZNDU
 YSkymaEcbUPqLVUyoo1fgzdsHmeIMWnZIPVcJE73CHv4Ss5xJvOxlTnXWfq7l8MpGL2g_M57Nm.a
 AW07nw8d3OZ7qXniFNs4_biHfq93cvSJFRFe8uz1yZLxbYC4AuVdijg09_d7TGKW4pBQxVcQKgNr
 00p7riqJLYLz6dYMSjMBUgSJZRnXJkMDehe2Fxxkps63zDjbzZ4hHZCnYdYOih.1PfY5Bms6xX4Z
 7TEI3OihHb155emgbUV7HvdlfdPG_dKc04YEb6xRy69c9hnJ7xquKj.FhX7a_keyCgvPSpowGGnS
 qCJYdEm7cmihHkCNTcTiTMuEPDATScR2vE71Olb7tQ6g1r7ehNJZikXrkJKiSJxqZyLE0NDfQ8WV
 Yu0ioH3Y3tlLInGpdDXgfLvYEe3f3toh1zrU6hx9l4MwfIPuLQhjZfdWrIeNsPfWEHOx2BetGEHH
 ae0wOEWIdFBDbBeEqNsBP6RPrxvLtBt9q.qjVb0pAsB0NjB0aFIPl8XkWHN_ECYQOFUl.JD1wbS0
 o81cBnyle9FhTsM.DxHoFGQTzovggQSz8D_JrhtqQ4RS.tHurv.BaNWNj6tLrwt27NKS9YN_jke.
 mI3K7X11JhHK4GklHBXQS
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 10 Nov 2022 00:46:52 +0000
Received: by hermes--production-bf1-5878955b5f-gz9tn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a811e673c5d07df95e71cc480422bcf7;
          Thu, 10 Nov 2022 00:46:51 +0000 (UTC)
Message-ID: <b42a6fb2-ee6a-cb8f-aefb-ab671d39585a@schaufler-ca.com>
Date:   Wed, 9 Nov 2022 16:46:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 2/8] LSM: Add an LSM identifier for external use
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net, casey@schaufler-ca.com
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-3-casey@schaufler-ca.com>
 <CAHC9VhQONd9zFJswcAsY9-xQcRhoYwXtwyo4zT5XsSPTEtvuRg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQONd9zFJswcAsY9-xQcRhoYwXtwyo4zT5XsSPTEtvuRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20826 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/2022 3:33 PM, Paul Moore wrote:
> On Tue, Oct 25, 2022 at 2:45 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Add an integer member "id" to the struct lsm_id. This value is
>> a unique identifier associated with each security module. The
>> values are defined in a new UAPI header file. Each existing LSM
>> has been updated to include it's LSMID in the lsm_id.
>>
>> The LSM ID values are sequential, with the oldest module
>> LSM_ID_CAPABILITY being the lowest value and the existing
>> modules numbered in the order they were included in the
>> main line kernel. The first 32 values (0 - 31) are reserved
>> for some as yet unknown but important use.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/lsm_hooks.h    |  1 +
>>  include/uapi/linux/lsm.h     | 32 ++++++++++++++++++++++++++++++++
>>  security/apparmor/lsm.c      |  2 ++
>>  security/bpf/hooks.c         |  2 ++
>>  security/commoncap.c         |  2 ++
>>  security/landlock/setup.c    |  2 ++
>>  security/loadpin/loadpin.c   |  2 ++
>>  security/lockdown/lockdown.c |  2 ++
>>  security/safesetid/lsm.c     |  2 ++
>>  security/selinux/hooks.c     |  2 ++
>>  security/smack/smack_lsm.c   |  2 ++
>>  security/tomoyo/tomoyo.c     |  2 ++
>>  security/yama/yama_lsm.c     |  2 ++
>>  13 files changed, 55 insertions(+)
>>  create mode 100644 include/uapi/linux/lsm.h
> Unless you're getting paid by the patch, I'd rather you combine
> patches 1/8 and 2/8 into a single patch.  They are both pretty small,
> very related, and I don't want to see 1/8 merged anywhere without 2/8.

OK by me. One less compile+test cycle. It's nice to know there's some
limit on patch granularity.

>
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index e383e468f742..dd4b4d95a172 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -1607,6 +1607,7 @@ struct security_hook_heads {
>>   */
>>  struct lsm_id {
>>         const char      *lsm;           /* Name of the LSM */
>> +       int             id;             /* LSM ID */
>>  };
> At the very least let's define lsm_id::id as an 'unsigned int' type,
> but since we are going to see the lsm_id::id token used as part of the
> kernel ABI (likely not in this struct) I agree with Greg's comments
> about making the size more explicit.  I would suggest __u32/u32 as
> 32-bits should be plenty for this token.
>
> Given the other upstream discussions we may want to do something
> similar with lsm_id::lsm and __u8/u8.  I'm pretty sure I saw a similar
> comment (by Greg?) elsewhere in this patchset when I was quickly
> skimming these on my phone while away ...

Yes. The API friendly typing will be in the next revision.

> --
> paul-moore.com
