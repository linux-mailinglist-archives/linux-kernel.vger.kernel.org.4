Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D2B6D1059
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjC3Uzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjC3Uzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:55:48 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD8FCA03
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680209742; bh=cirlx/RURRBpHmxjtuxiWRcdIO6v3+1812bwOjTe9yQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=p9ZRBj3mn/nHSfV+f5KdZ0LAM1k6OQnzqoljOh8IwmM4eOnV4rpz+cfqU2ugyJdSrMZeOgH2XPv8L8wST7LyrfxFC+qeLC+D3X0avQdAKCWwoHowcICw9nUzZNMeNZ9a4zaWYOf+R5kZEkqrQ+BufrI0sNM1aAxMmvgfM1KPbAQhClPceL4uW4i/aQuP8N6TScZfZvVU3vQrMgWulbfPfWSeFHBGlI97hsMOuZ20gKspBeuWRoOnFqlL/PevF3sVoZOMgnId8s4gePqP/dgK0YIvyc2mZmsmrkQuXeaK9PGfp7kY4Y0qu1FUyxdv+M9QvBwTCAkc6vNK08OLXN2AKw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680209742; bh=Wh6WGNS+AA4xr8pz1TtmWXUTd0Bp4NhWNiCsN+Wd/lk=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=gFDCCPrk0cQtZaNi/HySh3bB4wIBU552qo4zRSXMAB1GIyv+jWjfi7JuXAxTA33ztFwIRbOa3+FeEMjvK+WlJX2OEFV2j25ZgNIzpURf43hhRozzEfzfIszUGhVZ22gLkvHFfNEhIY9wMBQXr+IGNhAIf5a7n8Oey+49r3BMSmTlFQYtmg1B7AAZr+o3Ao5C0ltPxCV8ynCZiXYIeCN6Il1bMY+vBMalKBpmu5X/nrTdl3bPejBZLVEqoWLQa38LkkJ71bNybgv2CPalKrX4eyNM3T/s4Dk33qog6m7BHT8se5zwfBt0jTxnuDOqu4XRF/dadsq82Ya3pJ1ma0sQlQ==
X-YMail-OSG: vvqwVaUVM1mAAVSKYANsHk8Z5KbIg8xVT9pwFua.uUm00aVOBCk1_jh3uzju0VM
 nmRmnEA5SX9YVfwCRn4zIyCDDOWp46E.RR0uEZ4BscY2eXGrdMgjrZUohU5eCRxUhNxcaA1v9a5J
 HaDm92P0fRrefLdC3r_HV6XJ8w.alYttuEubzyDu_03N27uF51Dtrec7aws.WRq.vcvYV4ZQihJW
 HQMy.VA5T3Xtvz8.Uhh1qIVwzFgzifzjs85kDC301SrNMtRoAqjV47gWK3teHQ3Sb4NYBJSAv1fL
 og9o1TXU9NcuSfiNgVKsXTIYky_7PiXX34xgFgDRmohautylB3ZfX1yIqO77dNRIqxVWj.dt1ozH
 fxqD6rclXtVVZ2zGUUfkEzGNX.xvowZMlSyLPnTOigOpKmpT2bpvY9LM4pewWtraF_kS982fGfL6
 zcDLSCh_7kC5rw8Bz0AqOCKnY0vuFTu50vvk6BHe7jFcooGJARv4CopvO7wm4aA99w0J2eQwOHtv
 XwJBLGhkmzQr4nGfloHmS6oJQiYRfdUhI2PSUOijnkVD2CsIHLFlNPp90YbYzFxJDvFoWi.ajwf7
 xHyPM6T48G8NtEzJ3pkXc7TaUgWJfJxWym5C2ypEZdALMhC2rz8yhK.tcRMIJydOnn3TKAZ0S6WD
 aeze5rsGF1BfpNHkV6WZOXbBFq3u_McM994qi67NbhWC7WznkPQsl8yhPNs4HVuXLPz16vcp_nCJ
 hKS1NvqOYinSvktnB4iFFtaz8o8jC5tCZSWbejacw.OfJRr_7X87VBqOC4gUtYwD0YJjdpqNUP0l
 L8hU3JWOaFIasuAkCJtyA6YRo6K7dnDh.JoACWYEiJ70.AdE5gLx9mds62Qgmhb8MUPAb7BAVNyE
 ANthC4LA2hkQMqriUAJEjb7s01k8UEH8_ryn9YmMdBKssf2LXtXU0abqDbyo9EyIpVEU346a4nFv
 zx2JCzJYpb9FWBs4tzipPARWWpJVQrkfJH8Gm6_7gKggy0bkm4XU_krHcAS2pSGjCLUmvepeziI9
 s1jj6PWdGQmuf.CDAknBZVv3H4RS4TmkIbpJJ8Ma_RJXUPAl_fXNC8uo4cydodmhCkdWSRHI8TTO
 v_PK51v9vBVYknKqFpPW8iwaeCbwcunij_EcfsR3ByRtOfuszb_YrdGxD6V1JY8IRY6dCy5vZKuL
 T_UQJTtNfLTJN9IFp3zP67YSlOfhvfmnmYflvXPhlXVTeVzV6DHvpnDHFfNkmQOksmOiyU.pQxuA
 NdZiCmvviX0RP3DTfevEfJHbyxHJ5bW2WU2JpWOWDNM6W_6OC7kr24tYyfSv0pYQdIGzfVuXb7wF
 cQTbRNkhRaJKTaB6kbb6Rz2jsiRe5OaR6wDXPaqXXdw1bJOhEGYa.tUes7o9NZhhIt846c0dBC2c
 SGvVxFoVdt0X2pyNYuYRv.MMqFCNPoZ1.BqtWa1nXY4xiG_xNpYtzelr7fMfmWa_d69m44SM1t0X
 tQFV5UD.Iy4wzuIylsfwVEo6p_7LsD9KAOVejnuqnlMkgXMBxk_YBpcn.sErecGPPj2DHfSsI5Ac
 6txVOsHImLoZfrMSxM5ZfO6qcwJbV8XRyLYqS3stbbk83qJkzvqHYj5M4OKaZ7iXk.5PIKqBRVRQ
 xPF7u2ulHHcdc5XFAl1xNNGRZ9N.UcTV7L.IYFlfxPILK4ooCBUMmG9nK4N5i8y0QaXRX9D9Yg6X
 VD7jq8dp_UKdw45vZ7JgioZVcC7lzqTL1nm4ErEPyixU4XBw91p3MubAOl4DOxY4zvUHWmqNcqX3
 dH5Q1r1sPX_dvGItMF7C12ZqunBFIF0YyXmopc2WEZ_xMrYE6kNOdrMh_5awVH6TQF3Xv33LjDP1
 XiOUWWCWhcEwUm3BGGviMDTkU6Bh1.s24GnUbrRmsr1OHuQJsaiskCh7L9r1KA6dSSFL5k2oPuIx
 zGU_fABREyrc1oOqPyc6qdAulWKNxmDuDPkqlFQsDLh_tFSy23D6ZvOkewMVRInRkJOt6akjWW.v
 pGMN3y9Na_OMwkj8NwDMB1CfdBRwSVga3pxKXQNSP8yw1jjVIEghnNGuYKdasJLt.SCC5pR0rHYr
 itJp9QPsDDL_J7QrzGTBQIHVOaXW_IwYD_ZId.345tfrp7tmrmb3XLrukFkVlr2uXp119svhL2m1
 9CB_xtjexmzKoYTou5SOGz374uiKoIhqi4ABl5EnOSwhIWHaL2wEj9deOmok7oiHv9.Ov3976lR.
 UX3FvD2sqI55MK0LHWwYoruxUI8Wb5tuS
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f24b4bde-2ee7-4b81-848e-ca40c3a00d37
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Thu, 30 Mar 2023 20:55:42 +0000
Received: by hermes--production-bf1-5f9df5c5c4-bqwvr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fdac0784c3ddf1a331b6ed32d7fefee3;
          Thu, 30 Mar 2023 20:55:38 +0000 (UTC)
Message-ID: <61d21f68-8e84-ad85-ef20-fced8c8b916d@schaufler-ca.com>
Date:   Thu, 30 Mar 2023 13:55:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v7 10/11] SELinux: Add selfattr hooks
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230315224704.2672-1-casey@schaufler-ca.com>
 <20230315224704.2672-11-casey@schaufler-ca.com>
 <CAHC9VhTyMmyB5Yr8Zp+Xg3R=J9VLp-oChxJPcAv+fL8czVzcYg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTyMmyB5Yr8Zp+Xg3R=J9VLp-oChxJPcAv+fL8czVzcYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21284 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/2023 6:13 PM, Paul Moore wrote:
> On Wed, Mar 15, 2023 at 6:52 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Add hooks for setselfattr and getselfattr. These hooks are not very
>> different from their setprocattr and getprocattr equivalents, and
>> much of the code is shared.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Cc: selinux@vger.kernel.org
>> Cc: Paul Moore <paul@paul-moore.com>
>> ---
>>  security/selinux/hooks.c | 147 +++++++++++++++++++++++++++++++--------
>>  1 file changed, 117 insertions(+), 30 deletions(-)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 9403aee75981..8896edf80aa9 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -6348,8 +6348,7 @@ static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
>>                 inode_doinit_with_dentry(inode, dentry);
>>  }
>>
>> -static int selinux_getprocattr(struct task_struct *p,
>> -                              const char *name, char **value)
>> +static int do_getattr(unsigned int attr, struct task_struct *p, char **value)
> Are you ready for more naming nitpicks? ;)

I would expect nothing less. :)

> Let's call this 'selinux_lsm_getattr()', and the matching setter
> should be 'selinux_lsm_setattr()'.

As you wish. It's your LSM.


>>  {
>>         const struct task_security_struct *__tsec;
>>         u32 sid;
>> @@ -6367,20 +6366,27 @@ static int selinux_getprocattr(struct task_struct *p,
>>                         goto bad;
>>         }
>>
>> -       if (!strcmp(name, "current"))
>> +       switch (attr) {
>> +       case LSM_ATTR_CURRENT:
>>                 sid = __tsec->sid;
>> -       else if (!strcmp(name, "prev"))
>> +               break;
>> +       case LSM_ATTR_PREV:
>>                 sid = __tsec->osid;
>> -       else if (!strcmp(name, "exec"))
>> +               break;
>> +       case LSM_ATTR_EXEC:
>>                 sid = __tsec->exec_sid;
>> -       else if (!strcmp(name, "fscreate"))
>> +               break;
>> +       case LSM_ATTR_FSCREATE:
>>                 sid = __tsec->create_sid;
>> -       else if (!strcmp(name, "keycreate"))
>> +               break;
>> +       case LSM_ATTR_KEYCREATE:
>>                 sid = __tsec->keycreate_sid;
>> -       else if (!strcmp(name, "sockcreate"))
>> +               break;
>> +       case LSM_ATTR_SOCKCREATE:
>>                 sid = __tsec->sockcreate_sid;
>> -       else {
>> -               error = -EINVAL;
>> +               break;
>> +       default:
>> +               error = -EOPNOTSUPP;
> The error should probably be -EINVAL.

It's possible that we may add an attribute that SELinux doesn't
support, say LSM_ATTR_CRYPTO_KEY, that another LSM does. This is
the same behavior the other LSMs exhibit in the face of a request
for attributes such as LSM_ATTR_KEYCREATE that they don't support.


>>                 goto bad;
>>         }
>>         rcu_read_unlock();
>> @@ -6398,7 +6404,7 @@ static int selinux_getprocattr(struct task_struct *p,
>>         return error;
>>  }
>>
>> -static int selinux_setprocattr(const char *name, void *value, size_t size)
>> +static int do_setattr(u64 attr, void *value, size_t size)
>>  {
>>         struct task_security_struct *tsec;
>>         struct cred *new;
>> @@ -6409,28 +6415,36 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>>         /*
>>          * Basic control over ability to set these attributes at all.
>>          */
>> -       if (!strcmp(name, "exec"))
>> +       switch (attr) {
>> +       case LSM_ATTR_CURRENT:
>> +               error = avc_has_perm(&selinux_state,
>> +                                    mysid, mysid, SECCLASS_PROCESS,
>> +                                    PROCESS__SETCURRENT, NULL);
>> +               break;
>> +       case LSM_ATTR_EXEC:
>>                 error = avc_has_perm(&selinux_state,
>>                                      mysid, mysid, SECCLASS_PROCESS,
>>                                      PROCESS__SETEXEC, NULL);
>> -       else if (!strcmp(name, "fscreate"))
>> +               break;
>> +       case LSM_ATTR_FSCREATE:
>>                 error = avc_has_perm(&selinux_state,
>>                                      mysid, mysid, SECCLASS_PROCESS,
>>                                      PROCESS__SETFSCREATE, NULL);
>> -       else if (!strcmp(name, "keycreate"))
>> +               break;
>> +       case LSM_ATTR_KEYCREATE:
>>                 error = avc_has_perm(&selinux_state,
>>                                      mysid, mysid, SECCLASS_PROCESS,
>>                                      PROCESS__SETKEYCREATE, NULL);
>> -       else if (!strcmp(name, "sockcreate"))
>> +               break;
>> +       case LSM_ATTR_SOCKCREATE:
>>                 error = avc_has_perm(&selinux_state,
>>                                      mysid, mysid, SECCLASS_PROCESS,
>>                                      PROCESS__SETSOCKCREATE, NULL);
>> -       else if (!strcmp(name, "current"))
>> -               error = avc_has_perm(&selinux_state,
>> -                                    mysid, mysid, SECCLASS_PROCESS,
>> -                                    PROCESS__SETCURRENT, NULL);
>> -       else
>> -               error = -EINVAL;
>> +               break;
>> +       default:
>> +               error = -EOPNOTSUPP;
> Same as above, should be -EINVAL.

Same as above, there may be attributes SELinux doesn't support.


>> +               break;
>> +       }
>>         if (error)
>>                 return error;
>>
>> @@ -6442,13 +6456,14 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>>                 }
>>                 error = security_context_to_sid(&selinux_state, value, size,
>>                                                 &sid, GFP_KERNEL);
>> -               if (error == -EINVAL && !strcmp(name, "fscreate")) {
>> +               if (error == -EINVAL && attr == LSM_ATTR_FSCREATE) {
>>                         if (!has_cap_mac_admin(true)) {
>>                                 struct audit_buffer *ab;
>>                                 size_t audit_size;
>>
>> -                               /* We strip a nul only if it is at the end, otherwise the
>> -                                * context contains a nul and we should audit that */
>> +                               /* We strip a nul only if it is at the end,
>> +                                * otherwise the context contains a nul and
>> +                                * we should audit that */
> You *do* get gold stars for fixing line lengths in close proximity ;)

I guess I'm the Last User of the 80 character terminal.

>>                                 if (str[size - 1] == '\0')
>>                                         audit_size = size - 1;
>>                                 else
>> @@ -6459,7 +6474,8 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>>                                 if (!ab)
>>                                         return error;
>>                                 audit_log_format(ab, "op=fscreate invalid_context=");
>> -                               audit_log_n_untrustedstring(ab, value, audit_size);
>> +                               audit_log_n_untrustedstring(ab, value,
>> +                                                           audit_size);
>>                                 audit_log_end(ab);
>>
>>                                 return error;
>> @@ -6483,11 +6499,11 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>>            checks and may_create for the file creation checks. The
>>            operation will then fail if the context is not permitted. */
>>         tsec = selinux_cred(new);
>> -       if (!strcmp(name, "exec")) {
>> +       if (attr == LSM_ATTR_EXEC) {
>>                 tsec->exec_sid = sid;
>> -       } else if (!strcmp(name, "fscreate")) {
>> +       } else if (attr == LSM_ATTR_FSCREATE) {
>>                 tsec->create_sid = sid;
>> -       } else if (!strcmp(name, "keycreate")) {
>> +       } else if (attr == LSM_ATTR_KEYCREATE) {
>>                 if (sid) {
>>                         error = avc_has_perm(&selinux_state, mysid, sid,
>>                                              SECCLASS_KEY, KEY__CREATE, NULL);
>> @@ -6495,9 +6511,9 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>>                                 goto abort_change;
>>                 }
>>                 tsec->keycreate_sid = sid;
>> -       } else if (!strcmp(name, "sockcreate")) {
>> +       } else if (attr == LSM_ATTR_SOCKCREATE) {
>>                 tsec->sockcreate_sid = sid;
>> -       } else if (!strcmp(name, "current")) {
>> +       } else if (attr == LSM_ATTR_CURRENT) {
>>                 error = -EINVAL;
>>                 if (sid == 0)
>>                         goto abort_change;
>> @@ -6542,6 +6558,75 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>>         return error;
>>  }
>>
>> +static int selinux_getselfattr(unsigned int __user attr,
>> +                              struct lsm_ctx __user *ctx, size_t *size,
>> +                              u32 __user flags)
>> +{
>> +       char *value;
>> +       size_t total_len;
>> +       int len;
>> +       int rc = 0;
>> +
>> +       len = do_getattr(attr, current, &value);
>> +       if (len < 0)
>> +               return len;
>> +
>> +       total_len = len + sizeof(*ctx);
>> +
>> +       if (total_len > *size)
>> +               rc = -E2BIG;
>> +       else
>> +               lsm_fill_user_ctx(ctx, value, len, LSM_ID_SELINUX, 0);
>> +
>> +       *size = total_len;
>> +       return rc;
>> +}
>> +
>> +static int selinux_setselfattr(unsigned int __user attr,
>> +                              struct lsm_ctx __user *ctx, size_t __user size,
>> +                              u32 __user flags)
>> +{
>> +       struct lsm_ctx *lctx;
>> +       void *context;
>> +       int rc;
>> +
>> +       context = kmalloc(size, GFP_KERNEL);
>> +       if (context == NULL)
>> +               return -ENOMEM;
>> +
>> +       lctx = (struct lsm_ctx *)context;
>> +       if (copy_from_user(context, ctx, size))
>> +               rc = -EFAULT;
>> +       else if (lctx->ctx_len > size)
>> +               rc = -EINVAL;
>> +       else
>> +               rc = do_setattr(attr, lctx + 1, lctx->ctx_len);
>> +
>> +       kfree(context);
>> +       if (rc > 0)
>> +               return 0;
>> +       return rc;
>> +}
>> +
>> +static int selinux_getprocattr(struct task_struct *p,
>> +                              const char *name, char **value)
>> +{
>> +       unsigned int attr = lsm_name_to_attr(name);
>> +
>> +       if (attr)
>> +               return do_getattr(attr, p, value);
>> +       return -EINVAL;
>> +}
>> +
>> +static int selinux_setprocattr(const char *name, void *value, size_t size)
>> +{
>> +       int attr = lsm_name_to_attr(name);
>> +
>> +       if (attr)
>> +               return do_setattr(attr, value, size);
>> +       return -EINVAL;
>> +}
>> +
>>  static int selinux_ismaclabel(const char *name)
>>  {
>>         return (strcmp(name, XATTR_SELINUX_SUFFIX) == 0);
>> @@ -7183,6 +7268,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>>
>>         LSM_HOOK_INIT(d_instantiate, selinux_d_instantiate),
>>
>> +       LSM_HOOK_INIT(getselfattr, selinux_getselfattr),
>> +       LSM_HOOK_INIT(setselfattr, selinux_setselfattr),
>>         LSM_HOOK_INIT(getprocattr, selinux_getprocattr),
>>         LSM_HOOK_INIT(setprocattr, selinux_setprocattr),
>>
>> --
>> 2.39.2
> --
> paul-moore.com
