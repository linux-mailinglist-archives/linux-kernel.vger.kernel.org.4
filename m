Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0156AE7FE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCGRLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjCGRLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:11:06 -0500
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393439885A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 09:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678208683; bh=uR2F0m82Txt7jj5W6ahAE2trH56gb8/GQQ8y01ywGVI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=gdV6JS2793dIyNChmuaMmpcZGaUO2sJxq2ZTPKQktbkAG+yZrm/dmkngMnrwMQ0YtuRERlOFfKz/VfHltNEE78fg6FvWV8hQDlmcDEM63lvVtODXkKEzdW7jeoiBzdwjroa9lyrmCLSGXU9LwZOZQf0EEgUCCYbZBAelgJEYO3G+VVU2GGIOf7lqHy1pDmHVEO3ljGLg9GbGy7BioVh3Ht8Bg9QymnBkWcumk9vLc0rbgSLHar0QS+vfPxf87yqehRBwtUgBQ7K4BPnFXNUY/ara7UgYVg24Geo7MyK6vmjGywpnwNBXGeT2yCZSVREolkkQr6JYxLJ8gcnm+L8vbA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678208683; bh=16nbO0UsJ1g7V93berTg8WDk+BSIUpjaG05Og7qwPVH=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=jV1oHRhLaeTvYlwhtk7fhjSLgkr/eH2HjMYBIYmqAom9BA/aPFEcts2vDejQJwbTX53wMlfz7cptsbEqbYn8U6rADPdz8tLFuXTwxWU9Kf7AagWQhAfUYKkbFnpLsp3NPFj5E6ur7a9Xdz5lX1U69+CL02iazMHAFEZNS4bZyLSH2brlyGw6GA38usG5bcVWUULnpaa5xp04J551EIRnOfMOhYJLJHNGQwnlsGMEJX1Zo5fvu1BRIaEj+Gy/yQmEHjxVycx1rSDcO68NuXb4T76XsJRBsTKRAlOeRgi1PzNYc4kJnW2rjWz1lEDlq+IjMElH68UujSw2ali/VzU91g==
X-YMail-OSG: lzF61z8VM1nSzBKHxLyjBu4nif2__edNEHSj6fqiRpoDIkDmtEtzT0TPCyLPWc7
 JNv1o5fOXWi_PXFT1hortEzUYL6RXfWZ44DgJ5GuT.UIg_av1h.ID7h7Cym2QIwY.Q8_yiR_OCnS
 7WMgZLPoV6SMUMcC.aY5jd5iZSfv2K.f.syrgveFY4B.KROLFvWKd1lbGyKpiRvJqEYnTAxgKHlQ
 KzrTuNwtNqIikWZE1VPHotwPC.n8zZ8pDcQ_dhmqWQ6xHnMr2uHdwe4r6SSr5bs296Rx2UOJdhjY
 tEPUbUvP6bg0xi7QSuPEUyQSewjlWNCdUjFOSso77SSMab420XhzibyAZF2C_dAu7LxVt6ghQ58E
 rmek6pcqJH5kz0lxNvH3NaDJVa3fOrMFBQ_CKgR.rXzQR04ZlRa.CeS.K9duecCmUc4v97fN.S4c
 A_spmJZfkrG_gV1VPhjvkxwKQHnckBEtlEd2dMHPUVZR5SulP6QP1TpTyIurbbWr4HBqf_zxW.qI
 5c_t1ftzup_FK4NEiYhrnl2isH9IhVGjVABfNQnp9E41dgS8KdOS24UIGtObaI3fCWr.aijI1ax.
 3KRRMh8PdT64MJ3Le3KiYjVCm95JTeUnmIsCyilr4Eac_hWTBiIRyHsxRnO_Y.FprQRvW16m5Pa.
 eMJwVWLd4tjNnCvKxG5XFF52BrOtqUnnoBIlPHi6yPa1Fb.CJFzF4_dxQDDQLupy2eEzIJLOfODj
 G3nBDUPWUGe2ztUdqUEL4uShQSIarRZSDEX1wCayGk7xWMzhJS9qk7iA3VEuixDCye05ETOyMBgs
 3ldSAh_alOrSUc9ikoiz8r4H8Hla3YMxu3HK9QL8R3de5LnY8BFQhMpXK5WCyHXWBTMh2J761c1.
 fmg7m9uN.JJQnkX3uwLV.u79EVnn87TrL4KkGh.bV03Xu.rk_bg2Cn9TSlEBy7OyEdWOAhmcIlfE
 k_pd2DyuDLKrluVluPR1.1w0uGYJTtYC7YOCtWUh5OPaBPNuT41DwhUUkjaF9.EC0psMjWZ3qFxx
 snjnmBb.C61PtEGVFb6SkPfkCnG2UmWk8oAuFq2yG6i3X6pKfcwtrE49_69.BtNz0T398oUeU77i
 ICexa0.LyZjNuNFIHDnzJ0AVmKJCJGyIFHKTBMsee.Gm.Y8T7pesyTuEY3JoXJbf8OMOrpe2GLSL
 zGWQZZgMvxkSMJ6tTFrKbowgsE6hn.nHa9q0POlOlKTaVsAqV_tQGfLLipEKCM0nrSgdQ4i4zlIw
 lMKxxL0iQIQ8RcwA2y5pcrTfpZ2bXWiH4lxP6ujd24K2.VGZMjWvL38Wse1s6GQrPigcG1UbB9.x
 a_HEDzOo8zgnCCICAiFuo5hcGm8Iq3_TABbgTqqQ0kbTkc83cSzQoyKRUO3qTXOtUBM6GQSVhRDW
 I8e1LifUX.sS_m7kSkpAQp7XgfOMlYc4kSNQlQA9wEa0.aI6hQN7Xb8rvvVtLsXIOVgJEE9naXFU
 rt0kOwWSHTFzIxNCekbNVaEu1Er9aFz8AYICOibBS_cHmC9tT8bOglWDkyDQJm3u1G3Tk0A63ROW
 l9evRGkz2zY_7TqvaC2KOSi4GBg0TVsTrk1ws49Qi0KEocl4Flp4cCxEN_NE4QAckUaOfihEmn4T
 OxOTdZED.fvMPW1_Y76oKUSTZQ5HsacyeN0kb0Rubqb47n_2wMlQTzSKizw1ugJQWV7DtIAsiN5N
 4LeOb.UefcRyu.H0JqguIzZfLwbz1RhQbEXzCh1d656_.F0tye7EOTNejpEVnWJrT_nrZW1qbsfV
 fgLrksCXqDtuuJx0WnnCU_GQbQXyX3MRebRqcd5sxfP863wQFEgDoZDdoFYM6nBXCJm4HMzM0Ssz
 X4WWIpDE6_IBKgNS5kp8EhrDZRX6ubTCiV1fK8Ng9BEPS6Pu1Xz2g2B94yUjCBtk8huF0DG6Yj40
 AhBNQTKyD70yXMCRwsNCxWTeBD9Ezy3pDh9sdNizOJwStkc5dQrOX_wLpZcCKYNjsGjgy98pK9sS
 VnmLMOogqeELeFwq2WvjMsVV9iaOuDb8b8uJon10nO32VelObQYQEFtgKAQW63KxVd01ypf5UCwn
 THuyhbvZpSDGWam.JpFnNXDnHOf2HoRTEkN26d0KE_skZALv906FcYDvzCzOtnEYQWmDMZG2UGew
 M5uXDI9UD06_EjMmtd5hqCaunLi3o8oDJP2oVT69_3yCd3dIQo2luVPpUvjL6mCj9Ygn4OllOiR9
 QrEuT944F_o3LoFSJwVcgTyHanuSI2go3RflJcBAA0pqSBukEJPg1G7lpwxH0ghnKS_GWsY87JfU
 PRqyFS3tZE7x5Avca_UA-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Mar 2023 17:04:43 +0000
Received: by hermes--production-ne1-7688d778d7-xvwfp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1d16e37e4f17304c84cf9568ec9bd587;
          Tue, 07 Mar 2023 17:04:42 +0000 (UTC)
Message-ID: <382d4c90-f237-bb8b-65d3-6d22ae893f9e@schaufler-ca.com>
Date:   Tue, 7 Mar 2023 09:04:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v6 04/11] LSM: syscalls for current process attributes
Content-Language: en-US
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        paul@paul-moore.com, linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, casey@schaufler-ca.com
References: <20230222200838.8149-1-casey@schaufler-ca.com>
 <20230222200838.8149-5-casey@schaufler-ca.com>
 <83b6310f-6101-2cdf-ec41-b850fe66b1c2@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <83b6310f-6101-2cdf-ec41-b850fe66b1c2@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21284 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/2023 3:56 AM, Mickaël Salaün wrote:
> Let's say an LSM need to pass a file descriptor instead of a text
> value. Would that be possible or would it need to use another interface?

>
>
> On 22/02/2023 21:08, Casey Schaufler wrote:
>> Create a system call lsm_get_self_attr() to provide the security
>> module maintained attributes of the current process.
>> Create a system call lsm_set_self_attr() to set a security
>> module maintained attribute of the current process.
>> Historically these attributes have been exposed to user space via
>> entries in procfs under /proc/self/attr.
>>
>> The attribute value is provided in a lsm_ctx structure. The structure
>> identifys the size of the attribute, and the attribute value. The format
>> of the attribute value is defined by the security module. A flags field
>> is included for LSM specific information. It is currently unused and
>> must
>> be 0. The total size of the data, including the lsm_ctx structure and
>> any
>> padding, is maintained as well.
>>
>> struct lsm_ctx {
>>          __u64   id;
>>          __u64   flags;
>>          __u64   len;
>>          __u64   ctx_len;
>>          __u8    ctx[];
>> };
>>
>> Two new LSM hooks are used to interface with the LSMs.
>> security_getselfattr() collects the lsm_ctx values from the
>> LSMs that support the hook, accounting for space requirements.
>> security_setselfattr() identifies which LSM the attribute is
>> intended for and passes it along.
