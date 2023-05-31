Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5FE718D71
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 23:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjEaVrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 17:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjEaVrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 17:47:03 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8980A0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 14:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1685569622; bh=68KwFwrXmYDr7xS3tClDq9Re31VX8jh6WpfE9mcC/8k=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ILPAoS5KH77Iudma8l2bH3tf6KhrIJQIh0I9Ncu0hoKWCp9ggx5j5Tj44UA7TvdVEKJu0on1RXVJyTVLy09Hpn3ogTAVmUTTAhgJ+m4NyN3XgCsrafWcawrvTyFiYlqUxglEL54BfkMrDn49S5rpZMRfFi1xywCWE6WtNcW0b0JQzUAhgB3kFd3lsEXFkxSR2g6LUBnvoDeEGkfup979nhklJyskcraihL8IPnwiGNZx8TIXvdEjB9xjtREBZQEW7BPojCiIg5Q+OxUwY7fY9etCmO1o+9roLD6BFNGbuPQ61xaAmxRMeq4o4JgBbxgHUMvz4jOYCQkskmH+KGiwDQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1685569622; bh=B4SLWSH/kqKnPEpwjErKZyrAIpufG9J3EUhGpH+i00v=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ufe2pfL1p+IaLAv/mYgwPzA2NWNl0liQNWp/ytmuTyAGCiM5TdU3LOPBDQKNFE8LO5F1BobfFfkZCRG/j4h9CJa3o7n/9C/niryPiHIYb0Id1naF5ICuxV0EdZj7543mU2HKkvL0j+beVy2dAx/D8nYAG7YpvxfKyLPLZHRxZwy6ZLP01BwXxYTdmkwzo9vJZcn+CDvtWly1MQ5CTJAfiaauC6C3zYJIeF+DmdBXBgo4Js+xlBbijLRrSp8EbkNU3lXzXNmsuOBaCtwwO4SzrdvpaTWbOGGM2mJC9+ymkk8ftJ4DSQHIx8cpTVHdLni2lrFJgMLRFVuH7P5am5FoHA==
X-YMail-OSG: cVUoH.sVM1lJ6gvny0eX2qRVqtIQhPiljwfwLwelWM0bcwP5_z0SyYJREk_S8Nj
 rTDgWiYjDTq7iY6y_HkAKR5xy5wLxynA5L7SI0jyc3zjtIcl.7RJPycduBtUtdKt5pjuTrGSANPx
 QPP4ZC1X6cwU4JqvRvq3FRSRWxFeDQeuqtN4BbucM._2xcPeBEHLiPn.xwxqNVDu17e0yan3Omsl
 DrCuVZd3T3RHA_N8pPMYFJOaSY_bkRVi1xN_Lw6kVq1MkTd_GTWnK_IET63Su1XkgXE4gn.uATbW
 8mrWtu.F1IKzOOOxHrr0tc3_V9eKGAafljoAFq2sWqnPuYxSiqX_0KsWiocc9uj9x7U_u0Pb2y0F
 OUFhQKSue3ly4gYelBoLecORnZPZkghNiS2HnCj9H_B.tBYMPXk3hQxrcGzfgC2wYCfFFaSRJIhj
 dvEOkVN8o7ZEcR9Uf7DRprwIKYEmdvXQBNwelvt_fC2JbJ02VErB3bLII35N1HImBTBEAteeHPIr
 XvtjmpKtv24CXCQTvMM5ohl7LMJWw7SqBOajnuOFEe0JR6cVUlSrA4v9kIzh9gthabKKYQQbUgyV
 yEOlUtjPuyzQoA1.gOaiBvT08Y0X8GHAwY9Y.iLLKTuPy_KoYlshMrtsJTZfhLEFl_HmNc0wSU6j
 Z1ecmZndkhmzGnLINaf4BGcgnXa4Ooo9YCsIfApcfXdxdOq6aYwQO7afMf5S4pRLg7Sk.6jUFOl.
 ObG6WQd9e9yk56YXxcWCyeF0wA.EFT3BA5z6aulbLgF9_AX_0J9H8sr7sLNEpBp2dLtTVrLaF2w0
 chbZr1muPtEfZ_RgTJzlLd67QtwH5lGYwGQ4RW5xSdbTfkOrQHEasXLah8vEANh83X35ep4gBZoM
 6SL4aHSL5tVXW2efBOcY3Hs0egs6ihTevl2UsQcYZWbXo26guN8rnRHbiF50ZwG9sZjwNB.GiiZ6
 LDxcuVLRzp923tWWXYTp_.WMKYGqTp1x_M.H5EJOPM3eF.xrv4UFDFs.xWM6Tkc7PdK1gUTBH0FY
 JYEbRbOFkIivXV_sJk8R5ZPmpm7vvns6uONhrpDKS_OiufTGLOj3uCdZoiHBW6l7lyHwmqt7Lot4
 dlqCOzvhnTIF.CdkfVMZyHgZNuCOoy20rjzdwUaHzi4SNP_qEj3aCCcNmVnpbowKlDMmR2R7AzSV
 dbS9.PY2slrelUyhzvj9WwTvhDMnhMyx4pbnuRXrnCqg2sLcL75Ed.DmxUnXQfORneQRi8cuIfzk
 xIn2FlH3jnaVSjYdckbyqAAVWInNyd4vUAAFTBEXuGPaVcdxT5UsblQi3PmiU5dtaziuRbr.z8qx
 mpKS.SP5jmsYAcvDi5OY__lhHK.DL_1Xu1kZcWv1AkZ8qih47SJgkQt99waWGEFYdbpU9xFIxjrE
 Lfubv6b0.3tJ1slP6VkLjA8I4R9Puzk5IgvQeE4AS6zIeUDsQsix.jk.XsIWah2gJs4DbGJ2iDPl
 NzPCIU9uVr4yM7oFKl0U.7hTPWHJJwJTNFAbeJvWhzjF8fn1o2BeQmFCVbkqfS9x6b59vc5KCCZF
 YSmtm0GavDq1wXauAheyXUtR9DrCbnbmAX6FjW4QOREwecaJOmz5n8zAZjrR9MwBq4gvAXLGGq.G
 ZEBb18pAwmXSYx716w6rIKNXghwL1GgUsCX14Ppg8vtj4WVemItXr0ue7U309fvqOGUGE169DkcQ
 SbOb8NvbWwmqZvv0g98uTcjPJ4n.7ghv2z2YEG1h29xq4owFH9s1R1UZ20S9oLe7lhQi.Ug3Lilg
 R5ypGAd46XUs1tiqYSchk91yqs2k12tO6rdqY0shAHnu8G0aZYMqhOwhGHETQ5UhWhPjm_cQdWDG
 mOIcHFl58Osoc4LgaKGcolidHrSz375QXFbwyeftehgjLuQuX_N5jZxCzGpiBBltWSRFt5JZiI.p
 6czYhrqwVIHpeSEfVw_rkHk4ya.irQzMzyPHIc3tHwfSkUenJ5ILjNHRoWqwvtAtDyZF0q9hRizG
 Y2H0q6dgnDlQYKu2pI77qdh8FoxJlS.qwEEnEyWQXAtCd9GBfjV6IMMI6yqqlAJWyPQNag.Ilq0Q
 fKeAfW3UBxsgeixIpcx1GF2zOTEJuNdaEMX.C4FF7GeirP_rf7hvHK0OjYpCFzAQqerVrNNQoKAZ
 RcuwY36E.APYBcn.0tkckelb8XzB054MSBYAmnvCqTsfsruZYZ1Ies20RMASvRyFfgjGZORQEhFA
 q0MP6G48xRbnGvArvLwo.X2LzsGmDOUktfBOo2M7cSp4vm0vEO5LRvGR_jF0Mrkmpov8XonACcaK
 5_I7hQoqdXXrnQA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 81acc560-f540-4bc4-acd9-a27d87988b0a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 31 May 2023 21:47:02 +0000
Received: by hermes--production-ne1-574d4b7954-wzfzc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a5338ea7f44e42188ddd5cfdf4c4de45;
          Wed, 31 May 2023 21:36:29 +0000 (UTC)
Message-ID: <0a2b8372-11f6-56a3-7d8e-41e93d1bf691@schaufler-ca.com>
Date:   Wed, 31 May 2023 14:36:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] LSM: Infrastructure management of the sock
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230531110506.142951-1-gongruiqi@huaweicloud.com>
 <fe6a0f1e-6378-a4f2-f995-46799ed5248e@schaufler-ca.com>
 <CAHC9VhQHUKXLejiMvETYE_PJz3cyHPF5z+T1ifUCD9ezMztcSQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQHUKXLejiMvETYE_PJz3cyHPF5z+T1ifUCD9ezMztcSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21495 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/2023 2:10 PM, Paul Moore wrote:
> On Wed, May 31, 2023 at 10:00 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 5/31/2023 4:05 AM, GONG, Ruiqi wrote:
>>> As the security infrastructure has taken over the management of multiple
>>> *_security blobs that are accessed by multiple security modules, and
>>> sk->sk_security shares the same situation, move its management out of
>>> individual security modules and into the security infrastructure as
>>> well. The infrastructure does the memory allocation, and each relavant
>>> module uses its own share.
>> Do you have a reason to make this change? The LSM infrastructure
>> manages other security blobs to enable multiple concurrently active
>> LSMs to use the blob. If only one LSM on a system can use the
>> socket blob there's no reason to move the management.
> I think an argument could be made for consistent handling of security
> blobs, but with the LSM stacking work in development the argument for
> merging this patch needs to be a lot stronger than just "consistency".

I'm betting that someone has an out-of-tree LSM that uses a socket blob,
and that the intended use case includes stacking with one of the "major"
LSMs. I would encourage that someone to propose that LSM for upstream.

