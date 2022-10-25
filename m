Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DC860C0E0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiJYBTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiJYBSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:18:38 -0400
Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942231C11C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666658407; bh=1SQ3hcYQAAv2ik4bpnU9BGeaB846lGX2UcwpSbpx0LI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=gLLbxoiPBZYpF5Ss13hqdZaIeFRyuD7soqn1iDcsHQt9cpGRKY2nMOTNexXV6xyGuol+mojNVP5tZnfm8UVUNZEk9GdlLxMoYY5N9Do0FwJHJrYUHSlsMnb6GCnYD33bK7RDg7VmK6BFDTCPsrdyg5rHEDnvfec44kZRrroXtOhASNK8QoFZPi0mvYQSmq3EzNYMDX5AM3H4fvlBujXiH5MdzRx9dhtsSFZ35e3fnugn8HUZ+7AoWvWwErLthWdMDEHQ6+WS3/EqIklECIYIQWSYqzxX4NHZO5ZfqfgRKE8Q5dRywLrh4fXmBgssh+FQ0nSPXrRT405VA1zY99G/WQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666658407; bh=JrU+BnWiZ28uB+unR6ZRW48D5mOckorUyzO5tO11ttA=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Zn45U0FzfedqRmPsmDHUAYsbZgGW8FcN1uhQoQFZ8f3wD8kK7ap2xbNGKd0+PXFxl8UVGQ8Wtu4LCm0p6WRtqkjYojPD7xqVi5lgqjm+kYCsA5k5RLLPPhBhKBNATFm87TvosScxafna7OncYKEnVVPtrsxn7WCi7FFLRe0MQv+1+c7XSASUoqNkR7ut04TdX/NPE7C3EAmtqv/hLmGytU70xQ44dCbCNUte0N4vsrD3yN0WrNeehEfY59QJouqVX7SxUdtioJExFdK7Or8YL8kOuxQAcdohbdTYbWmMU5LUcultL0oeWuLP7RzbHSjXnd8vUb+TQ9c5Rk5OAZoaFQ==
X-YMail-OSG: Kjjy7r4VM1maFf0iCEa_zYJ6SU8lmQB2ezcC8XHTAu_WFK8ttSwXYa9EHv4Qgtl
 XySWlaXfog6NzkBNv2N4SP3Zl1bKz9Qfjae4FD8aOwCBlseoc1XI7mKrkU6hXeiyqvrlA5MAfA9M
 .knDKVONEqASJq63aFvENgk2OzxUoO9rjwbcP7dct3EYjkEu4_adSiAUWTPBEksqcjEujDp9IkKR
 FJFMUFtICuXCotwL1n3h35f0suV4A.Dnbms_P1pU6rpMRDf7cBDZCLnW4MkarXX306lIjpCxni1l
 d4tTMMAYiYV1bNm5v5e.qCMW4V_SMsOfFhxdPmu.sFukxmGWnAdEGLQBeMdo4f6WzoSrcUzgzCuR
 lRdxyvDFdq4fvLAGVHcQfbJ05FQS5x4Ry8tUbzOGKVUC7jTPvXHfBVTrVPblM4RQCG7X12r.PqWH
 BE.AzFNrIm2X40MgudKSFLRfGEiHAjS8UnpqhlqHY1yenmuZxCMjQNByD97t7guIAWxzypUJ5Cl1
 Ry2jpLSBDIApELhSsZBSLBS74jxSTyAafT5L_sbDRzWp0VHkVxWVinX8oEucUxCmzR2d5K8FYQlV
 fMnrZzB1qdAGBFKlNtXe0nsqhVwOAKqA_ZdPMlR7wvQgrVrxJX4APJrIlDyZOgVDAoE2g.loySaW
 fgKyRKmZXa8PqIcO76acICVziTMSycJ5txugNJAe3957o3GvxJTK3FMU_2fi5sCZCOmENhhdqxKV
 dEKW9pPvoidIOa1Apm24P6Zp6YQJC4rZRGCWz3hnskJ2TMxtunYDjzc5btN8wwdIEEXOo2fe75UR
 .puGW2LkFYBQkSLRHFwOtespLRoirUWdOa4cUoYadfGyWl83kBnZFsdhTxo1waWnwqrvfxFlVag0
 RR.bHuakzWtz8kTqJmbQ8QwL7TcV2fSSNW8LSNgd.jhCQuaatm.O4hNyIX4kZkbdHZECsMggjanz
 0EctXJAbGTgzWDjLq3NvY1dzOmCo_4Gm66CP_mGP8UzDlwkLtsX14PnjvLBV11NHg257Rw5vn5wp
 GXa4BMhnIxwsYZVfP1_4.gR8Sg39U4piUj0I.5IhpVT2E7HP4_qGFWAoX3k43t1Irbh.Bm3lm1Sa
 Eqcox9dkiLCWeE4vNM6AKwEIDLf8juJBUN4iLrIIZQr.6PSz09r0UxDfzi9wH5HdQnDFxihudOu3
 fVsiqqx9dBa2Al1ddjMu7bLtI4PuSrTw0zshYmYNnMf_BIRtD6DfSP5ybSKQk_X4MozzZeTEkhFa
 igRkhjUR0LbRNc1DhOj.0L42EpveW0QtRttgIIKd9fEP19A7R7CnrYr0fRAAkaFegi7zSUjhiHEa
 R4BM8GEbA8y8GWmaKUIDi7DTTkYYm4y.8HHbDtVBdQpKjAefCsMQEY1xJ_nY8l39nMUQQGjSXfCH
 jjeZm2byrDsbuHiTCKOO4dHna81h38za0syC.QnJWMf1SFG.JLKgdDh4F8QTTAbzf601UUxdueak
 AVa0w8mGZbQRZyPBk.NYSmNPNmusBI8emu.g9Gr03k7oMFef8engvQPCDdvXo7X.3OhTBspWhQDF
 p2xfCxpSHmQ4Nj4F0Lvq6loHVHZ72zEXX3_dAIdkneuePACBLpU.uN1kEEEawEpq0VWbMpdzf1xI
 LobAaGC7DdWzg0kzJEJc2gNhsQOLfqZCxd_uQQxoFPDLjNnlL1l4E4Q.3nsyd6_TqysZhfrFrMcV
 w9VRV2STsOeY9UBek7xUTVjGja7zV0u0KX.z9.4W1pjo8Cbd7l48XhSeZy_IXjSTDNsWHV8VexH_
 N7854WlUgQUpP57eorBwGhyGa_0YlY0T_nfIjxikF6XZf9yns.WcX18PJudw4TY1OuhTe.6dXZk9
 WPjsBlC3K_M9Wc1Vgd0FGrV._13JDyKasDQVXubY_CIAhriHkpboAgeZcGhmOxe7ttFSmCqYuPXc
 YQkyd8GERmBV7lJ7CqZV0zSonymyZWcggnWO0nzt3s09ibxQ50rLRedbV7kgy37kPg4LBG61aG0q
 QDQtPoIdfAHJ5UprWRMf9nOuoQj04OXXAqtrkqIsEd5kHP0X59KkilOc4Z9D4VQqmA07P_R4wBw3
 h7WByNXjVaQWW9.RPrdhjro3YrPck77y0PqpuJsv2oYdY09At2UEQtd6lqur.d4gS156oUXdLj71
 LPkBks7p0jrd5mQ7vZxf0FKmQgOk5JcPg4bNqmpW3r98E78t5svIrXZG78epwSqmcsDSXYsCEXkb
 gF27v3bpYKyO7lSYU_B_nTazev9FByV.1
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 25 Oct 2022 00:40:07 +0000
Received: by hermes--production-gq1-754cb59848-rl7fd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c725735263443336e82dbdb6410c70fe;
          Tue, 25 Oct 2022 00:40:01 +0000 (UTC)
Message-ID: <e52efeda-9adf-4128-1906-3c83f217b99c@schaufler-ca.com>
Date:   Mon, 24 Oct 2022 17:39:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v38 39/39] LSM: Create lsm_module_list system call
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        jmorris@namei.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        casey@schaufler-ca.com
References: <20220927195421.14713-1-casey@schaufler-ca.com>
 <20220927203155.15060-1-casey@schaufler-ca.com>
 <202210121459.00980C2@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <202210121459.00980C2@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20754 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2022 3:04 PM, Kees Cook wrote:
> On Tue, Sep 27, 2022 at 01:31:55PM -0700, Casey Schaufler wrote:
>> +SYSCALL_DEFINE3(lsm_module_list,
>> +	       unsigned int __user *, ids,
>> +	       size_t __user *, size,
>> +	       int, flags)
> Please make this unsigned int.

Sure.


>> +{
>> +	unsigned int *interum;
>> +	size_t total_size = lsm_id * sizeof(*interum);
>> +	size_t usize;
>> +	int rc;
>> +	int i;
> Please test that flags == 0 so it can be used in the future:
>
> 	if (flags)
> 		return -EINVAL;

Yup.

>> +
>> +	if (get_user(usize, size))
>> +		return -EFAULT;
>> +
>> +	if (usize < total_size) {
>> +		if (put_user(total_size, size) != 0)
>> +			return -EFAULT;
>> +		return -E2BIG;
>> +	}
>> +
>> +	interum = kzalloc(total_size, GFP_KERNEL);
>> +	if (interum == NULL)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < lsm_id; i++)
>> +		interum[i] = lsm_idlist[i]->id;
>> +
>> +	if (copy_to_user(ids, interum, total_size) != 0 ||
>> +	    put_user(total_size, size) != 0)
>> +		rc = -EFAULT;
> No need to repeat this, if it is written first.
>
>> +	else
>> +		rc = lsm_id;
>> +
>> +	kfree(interum);
>> +	return rc;
> No need for the alloc/free. Here's what I would imagine for the whole
> thing:

A better approach. Thank you.

>
> 	if (flags)
> 		return -EINVAL;
>
> 	if (get_user(usize, size))
> 		return -EFAULT;
>
> 	if (put_user(total_size, size) != 0)
> 		return -EFAULT;
>
> 	if (usize < total_size)
> 		return -E2BIG;
>
> 	for (i = 0; i < lsm_id; i++)
> 		if (put_user(lsm_idlist[i]->id, id++))
> 			return -EFAULT;
>
> 	return lsm_id;
>
