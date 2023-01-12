Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AF56667CC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 01:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbjALAgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 19:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjALAga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 19:36:30 -0500
Received: from sonic310-31.consmr.mail.ne1.yahoo.com (sonic310-31.consmr.mail.ne1.yahoo.com [66.163.186.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6FE62F3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 16:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673483788; bh=IYqk7n0Bx44uelg/P+E2Zokv3wcrxDSNI9bxrGGXX3E=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Kjk49rTgIRjnpGTHsQG4pHCNwQQKkKQhQ5WNnTeNlsRef2nvYG48DiqnPBBLQtehuEZvzMMOKSefKaJjH5J19tjOD5Lg4BBSlOSQfpTTUXYMHg6JIwipDF4AsMEEGMrGb565Wc57JzVw89/uzhv1jN1+E+1Jrf+LV+1up33NTwSsZPlL43he8flwNBjigEg+nqZEjLsYn2FeHNrJq9GLBSVu8GXWZD+qBYADRemUhZJcLqu3afYMlxWfmCLpBQAsINXeWwpIxy5srOqfKYZYXFgaGEFQmXVtbOWkXu+CwIcn50LokRi9ryHRnWLareCL5P7VZS8TUVZB7XAVVCFaHQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673483788; bh=PDv6mZ6roEUIDnPXeZkOp0Qo+YVxWllJBvEoqs4jJNU=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=NJDpmN7DfAhYdtgc+exCAJMmKsOk+layMIr9RONzFfA5cU8+7cYidcp93cIMGs37N+lpia6XCaIOaPHYAVr1CfAGNC2nCKJe6FWkfMjwCFVx4m/7ISq1o4Jgts091VQf/SwRI6kuL7GjR9IsQ0wfj1rTy9yMrMaVyRnNWI6HEWHoiyJFujFcQBJ5xs/Lu9BbrCwFxhuXV+fWPDBZkCoGgxfEvSTBudY8bOQMJSGHJjUV7of1TR3C/VMeZTroi0JrcxY7lySlecT5LpOvJHaA7VtSw8P3ZH/fdOBKF7lOxYxvrthWfDnkipAT1H1REZBKgoLxjC3JKYuXgSHPouiqIg==
X-YMail-OSG: O0Eg3SoVM1ki4CTMhSGN3pIgIGKw310BnCEmS48qW8LXPktHQXlRnZN_P194Jkx
 WQb1Evf2Wk7RwtWJVrA3XlGXFOi1Pvq7l2kxUSjTExBORDEfBUlujQMt_qsVPX_SwO67Kq3Wztdz
 NWpxCU3omMKKeygKPs_rp.vT8btCpR3rB8jhybL3lg5RkTCyrMpVGUI3cpXpakQLNeAPF4K9J0Bv
 8mfS_Ltf699nVUyfe3keV2UruOzVPU1tOTME_a45hkR0XrBVvLJ.9Y1WuPU6.OhIshXiagiitzki
 i_YkRaKcmcQ4lb1vTDMrGiINqqLo32fx1HrhM853Y6nmPNPC_Gtdjo9vPc4omgM.FlBIe1ppDgBh
 6o5kgOOfVSqm8UgWEtACmnjgVu.hZKdR6n2zR7B5wdQ4bmbGvDxQFe5s7XbO6M0emIkTkTxjTsSZ
 s.qKzUDTybNQo2tx8H3EdVWz4o1fihY3RSU6Qfs0l7U61tpwdevsvclyFJviXdk2iG6aae7HIQ_G
 dB6vuvWo.bCkBp7lJXdZXtj58wqtGM_IbaWOqRhUhGqeozE9sV34MfhnksCBnDM16pujkNm0ZeqA
 OBLEH9X7FiUagLAbi9G82UIsjdy4EOIqBPrahIY.Jb9TNkBf33rOrXiw.cyqsgxYP7WBcLLSSHJl
 zdiQiF2ME4Q_N8ZJ.n0ko1wvauU08p4_qL2sNNUR9V_jRaW.WePk._QkVhK.32lsGUKqpNoRNNKF
 UQCIjlNKhy12DntI4w2sxtgskTey1jaz2MTYBw_gGUtlckTyH5G6imGZ6fKK9oUCGWNmzX3yUOHe
 Pgt7UnMvAvcZTkI8PUVQ1XCo7LzxFuV5EL6yDlEl.oHJMJjr7SPKZzjUjfHZ5lpCk_SoKl0U2y1R
 hm9xBR.dSGE1UvMUj7rgQymyzKhh8_JOIps1._SD5Yv2s2EQMRdQtBE5EHGtMU1j5Q77dy_BIJwr
 t58kcuD3Pw4EaU8vJtA3JWmPQSZZU4cDtIAo6DiLBGa56UAAz67nuVS4tKObhA_9f7UN4_HbQybS
 6C17sRsvb4XTS6e7MN53ozbf_EYhdY9jdo6fkZjTPKymgBYJGPitTbWnMYkOjZrjSqf0zYJsHLte
 4NNE0kzUPACy.Cft3zp2nV8ZenNc13jyBayV3dx9vv0LUNucKx7NBm84fhFrAbjaQO2ARDD1D32g
 Y0b8kN91Ly37uruJRqBd.09UP5WHlD0b8I.b5lx_AG72sMnw8j0v8JNh.rULOBKa1e8JQ3zy8LLk
 hqVdt6sV1BuxUjaon9tFDVB73NsV4oSuwp97pa23CloHgYrPSeZYCzw32dLNmfGkMgBg.D6_4Bbf
 LuwfVsWEK5b0219R.7k4uljI7aB2IiKwnGTJvpc7E77cRsFWpLrAg0MQQpHAW7iT4A1pz32hgHuQ
 unJq.UaqJuEfX0t5MTGXUl_xUvpgXRmXa0tiNDeOrddbFTTESGefNy389Dbn39z1CAJK2vdMgkyx
 2gA2iHUBgEcwlW2uv49gS81_z.u6UflHEv5fJt30xwk1aly9OqYQ2ZW9R1.MizH_xhz4ViQ1ekd8
 0AnfNpPCWmhGWNqcQhRJDjO62pbYJCluZXlbbHQX2vykuzJIM0hc0pIEz.p70bbwEb0p0.pafh7h
 0rYxUFBqpqKjtj5Z1dap1VE_U5PcYD7bsEb9AZA8qkOUa2cr6nSPLmepBbqxvUc31B_Kqg59aPnB
 PMkUQHpD2_chuBpVkvjjIJmMLkccFzEmvM62p19gQCooB2TIDLQ7V3V4ZtYKDjallh4UDfhBMnUJ
 z5zWV.keIn8xJc2MHyEBSAyGzTjeKirflyK9no.FI.T6XoUdNVGibq03nQ2baenxIeX26QaM1icz
 dRsGs9A.t52CCSQxArDCxbyl8T9n5P_ypayiYdLKr2DPGkL4LTDggeP.S.CUfJHcqPAtMNbd5HxW
 RrqBys6Jo6kn2H1ZAWy1yVcDcAOzxc_mr.YTSdojdkTo3kMvBMG93dcRvGAbJXEZtrebKoE46gAj
 Oez_P2SnvflE5XvnSaI42g.QkYJrc7AAhZQd2_fE5ch_bpmT2EiCxkSYV3ky.A1YkEjZZU5QkT42
 NdS0pCHuOuQ09x3frWH2B9MbOe6Yt9xryyblNSrDPsnnEAGD1flylsHamW.CYU8QEvO8GHgElKLh
 aPfK4prfKr18aG99w28crlodt00zWn0sgFoX8PJsmG2iClRU_gB7fN4C2qEu2rLpIe2_VMNJsXrI
 qW4f9h_MQ461V8c1BIfsTn1oysFv9YsFs0FCMdGUmG6kxvU39O2UPbO2odMEAOv26p5XX6OQ7Nh_
 rJ0GOseo-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Jan 2023 00:36:28 +0000
Received: by hermes--production-gq1-5d97db6675-rm7qv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e40f0c23d0b9c07bd9df291f93dd4855;
          Thu, 12 Jan 2023 00:36:23 +0000 (UTC)
Message-ID: <c1acc2ed-d188-6560-4554-e6e37d47d06d@schaufler-ca.com>
Date:   Wed, 11 Jan 2023 16:36:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 2/8] LSM: Maintain a table of LSM attribute data
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
References: <20230109180717.58855-1-casey@schaufler-ca.com>
 <20230109180717.58855-3-casey@schaufler-ca.com>
 <CAHC9VhTaySsuvkj0U9Jbp405+WoRfhtq+ib5ynO-a9BeM+a5Ew@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTaySsuvkj0U9Jbp405+WoRfhtq+ib5ynO-a9BeM+a5Ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21062 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/2023 1:01 PM, Paul Moore wrote:
> On Mon, Jan 9, 2023 at 1:07 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> As LSMs are registered add their lsm_id pointers to a table.
>> This will be used later for attribute reporting.
>>
>> Determine the number of possible security modules based on
>> their respective CONFIG options. This allows the number to be
>> known at build time. This allows data structures and tables
>> to use the constant.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/security.h |  2 ++
>>  security/security.c      | 44 +++++++++++++++++++++++++++++++++-------
>>  2 files changed, 39 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 5b67f208f7de..33ed1860b96f 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -138,6 +138,8 @@ enum lockdown_reason {
>>  };
>>
>>  extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
>> +extern u32 lsm_active_cnt;
>> +extern struct lsm_id *lsm_idlist[];
>>
>>  /* These functions are in security/commoncap.c */
>>  extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
>> diff --git a/security/security.c b/security/security.c
>> index 07a8fe7f92bf..a590fa98ddd6 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -28,12 +28,29 @@
>>  #include <linux/backing-dev.h>
>>  #include <linux/string.h>
>>  #include <linux/msg.h>
>> +#include <uapi/linux/lsm.h>
>>  #include <net/flow.h>
>>
>>  #define MAX_LSM_EVM_XATTR      2
>>
>> -/* How many LSMs were built into the kernel? */
>> -#define LSM_COUNT (__end_lsm_info - __start_lsm_info)
>> +/*
>> + * How many LSMs are built into the kernel as determined at
>> + * build time. Used to determine fixed array sizes.
>> + * The capability module is accounted for by CONFIG_SECURITY
>> + */
>> +#define LSM_COUNT ( \
>> +       (IS_ENABLED(CONFIG_SECURITY) ? 1 : 0) + \
>> +       (IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
>> +       (IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
>> +       (IS_ENABLED(CONFIG_SECURITY_TOMOYO) ? 1 : 0) + \
>> +       (IS_ENABLED(CONFIG_SECURITY_IMA) ? 1 : 0) + \
>> +       (IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
>> +       (IS_ENABLED(CONFIG_SECURITY_YAMA) ? 1 : 0) + \
>> +       (IS_ENABLED(CONFIG_SECURITY_LOADPIN) ? 1 : 0) + \
>> +       (IS_ENABLED(CONFIG_SECURITY_SAFESETID) ? 1 : 0) + \
>> +       (IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM) ? 1 : 0) + \
>> +       (IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
>> +       (IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0))
>>
>>  /*
>>   * These are descriptions of the reasons that can be passed to the
>> @@ -90,7 +107,7 @@ static __initdata const char *chosen_major_lsm;
>>  static __initconst const char * const builtin_lsm_order = CONFIG_LSM;
>>
>>  /* Ordered list of LSMs to initialize. */
>> -static __initdata struct lsm_info **ordered_lsms;
>> +static __initdata struct lsm_info *ordered_lsms[LSM_COUNT + 1];
> I'm guessing this 'LSM_COUNT + 1' logic is basically just copied from
> ordered_lsm_init() - which is okay - but can you remind me why it is
> 'LSM_COUNT + 1' and not just 'LSM_COUNT'?  Based on the LSM_COUNT
> macro above it seems like LSM_COUNT should be enough, no?

Yup. I didn't spend a lot of time investigating why the + 1.
I'll look more deeply and correct if appropriate.

>>  static __initdata struct lsm_info *exclusive;
>>
>>  static __initdata bool debug;
>> @@ -341,13 +358,16 @@ static void __init report_lsm_order(void)
>>         pr_cont("\n");
>>  }
>>
>> +/*
>> + * Current index to use while initializing the lsm id list.
>> + */
>> +u32 lsm_active_cnt __lsm_ro_after_init;
>> +struct lsm_id *lsm_idlist[LSM_COUNT] __lsm_ro_after_init;
>> +
>>  static void __init ordered_lsm_init(void)
>>  {
>>         struct lsm_info **lsm;
>>
>> -       ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
>> -                               GFP_KERNEL);
>> -
>>         if (chosen_lsm_order) {
>>                 if (chosen_major_lsm) {
>>                         pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
>> @@ -388,7 +408,7 @@ static void __init ordered_lsm_init(void)
>>         for (lsm = ordered_lsms; *lsm; lsm++)
>>                 initialize_lsm(*lsm);
>>
>> -       kfree(ordered_lsms);
>> +       init_debug("lsm count            = %d\n", lsm_active_cnt);
>>  }
> Given 86ef3c735ec8 ("LSM: Better reporting of actual LSMs at boot"),
> is this needed?

None of what comes out from lsm.debug is strictly necessary, and
human or script can parse "initializing lsm=", but sometimes the
number of LSMs is interesting.

>
> --
> paul-moore.com
