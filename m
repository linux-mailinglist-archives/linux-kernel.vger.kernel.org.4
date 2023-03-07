Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301CB6AE8B5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjCGRSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCGRSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:18:12 -0500
Received: from sonic303-27.consmr.mail.ne1.yahoo.com (sonic303-27.consmr.mail.ne1.yahoo.com [66.163.188.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED0D9477A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 09:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678209231; bh=uZ18eq+KE68358mnuCeXuV/vvinw/K9wC8rXpWJAgzk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=qaYOAVMkNAhDXRUxJTW3PR09BRTcrumaZY3Wvw7wYaRO9eCqp+5O3z2vPiIJQG/tWRHdqviP0mbfDameMyttUyIrYdqz57/SpvBzBbZqskPhVtS2VlJkvl+zl5kz1g/dt3QqauEVjtmILHhWVyakTCRVrksgb7uYgFgeVED+C8jkvGsRvLseReNV9STO0HLBo8Uc8uLaF7C9JFzyJCiSo06QFuW8eFfNgJ8H7vfToJQ+ScZLVUn2kbAguftwM7iXM0X5bw2HjBn3/xXCn7NroESNYTOY11TPKLFSz4wUH5P/iKIVP95PcnoSzHma2Onz29Z+m6n+EiP4bN/DYxxmQA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678209231; bh=A/nx8p+cIlbaC8I2Bkszlxcodwtw8xUlfc5U+zY12nc=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=gEU/AG9mCqnzgqnsu3xuw97uj+6zIzy5+4eyNL4V6MHBxW9cJ2oQDpRom6V7UuVVT/iOf88IWAHzAAZTz9qKkxW/+CQzGHjLCv4P6EFDfm609wHtaVUD92geATK8dW363yoGkDnoIdUjS5vXfA+HFnhBomitm5ZZ+5f546qPR4amuH/aEhoWrksVC67YBDY4nPlLpc7sr2+s94cGjkvwwUQxB1cBuJOSYTberY2B8t5bnpuS8e1KeVocnw1vOzAV5O5bmlu58Ie/9DGfMM4SGWulTpj0f3U2T0D2f2bC22gLTSOQbFVQM4s3N2SkOgvETkT1aIuzGAeFmvMXPXjUFQ==
X-YMail-OSG: M6R9XRwVM1k_DWJCIKAtsK7u_P4H8o7YVo4CwYeFAwgscohJglT4atCq1JQL2Ia
 HJGMHOf43FBzIbNQAd4CGEMBnJ9BC0sRbL7UZIEuarkscSrST2m03P8V3wnN8kFyDrWjGro1.O6e
 xWJcXoujpmyYTXY4swhxnRjLpjKDcNIzIO.GPSgByH6vFrGTURTlfvhiFuh8fDUYYWC76L6tXVEs
 I9qIgGyXsiUSU4CTuThbMA.pZ5o4jRtRrNvmHyPLFigMloH.5kPftgllcHGgQCY7Up9vYBmubs_q
 Szqemma6RC9.nPfe8EwOzCeK6h1z.Yz2KpUNLXsp6qGS5jLoa8dEvdktQ1OB1FYJS34dp2ibCbWR
 kvShQa7eFr1Ovrdcr40gDsUmIfilbd.c4TEDFSrcI_zoMgc_srG.b7boOJFX2JHPFagAxPAhKKYT
 _wEMRNbRa1C_YWjpZo.knQTdg8R.SUInN87BGOSaKXwYxIEXhc80WYGFArvNyK4gED3R6GiBHUEv
 3gfMUpmbZrgzivjZmB03MHFJJ1w6JGdB3GTAwgnf4haXLO8P.FXD4FfFBg51mfaz9V88mLrFl3tz
 afAjyOeE5TeaGMVv44bB3oA0sPn0H8thvag_RzIBA8HgYk.Os.P0DDibH80B7yDJWCyWG_hSurtr
 21lUUwxDDxg_CRVZgoNI_U6.NS4sO5Ls1Ik3RXRk_Gddrkeat5gT4MNo_zXxs0ahi935zhNo4LdL
 sdVmQaq_pGAtACWCBzg.yIix0qGZb1YAeh6iQLBHftl.8nq3yqtHEXcGz50DgGw2qv9Za52Y05NL
 4UjLILbfpoTAoqIPOqfU.M15uIHdl4MIhpauUrPQk7VLaXGdchAt18_vEI8kQqMfaZIIez5vNK7H
 huLYLb0UrkS.lqi6jkG15plpoJtfIZpsgkl8OsYfmnooX1RwxruZAwplcF_kw_rtqzNDo_rXdIiz
 yuhjszoDtlN6MwO_LrhdZGtFAuSEfvYmcxajAyp2fD_Gm2qNUTM81mM9_rjuPpfUFcxitt1Zwt3N
 X8eDkWG5fBzTQDn__6snY97jxR_qY6_UBfupu8Z4dDpBk2W8kdqgiZtBpB1eqxP3WIkrG.YNnKGY
 gX5AiJiREWGJBOv7DnPHycMHpeVR7LuIHz7ZWh2F.SDFF3BwBMyBv8AhhXFN7hlJS.ASGoG410pm
 HcRHxqg57v7Sn6_kPANGVoNPqg_2nBmYy1yu.wqyTFOx5G2jtWY8POB1fmxkiJ2WwYIWVg3zEcTA
 BWU.GUZmfv9xBavgPTBHhufTIyfS5wJHf53x4EkB0QF87oJQYwaZ7HPD0rrvkynI7BZh7.ZQ38n0
 SpJKh98PI7.dp2r9cHxjWKejm7cyBmwVUyUC_lvpy_Q5qzVCfj9rC3rGuCmFTpPohvTocJMphd5A
 mPYJ0I3eLdCuqM1E8Ssg.60gYsW743Tdxg3kN3coPEANxOSsiU1j55UTdO8wKtA7QncSL1Rtx5tY
 FnCcwRpoGt49kQ2aD1_UUOnUGhGyBqJljN3W05PKuoemC41jsF9OETZ0mdwIQhkv82ZXCfWnMn1U
 mZlfJU9IIpsDx8sij8uNk9.cvnI07rcDy.FJop8uCFr4dPBDt.7HwlpotlZviKH079x48fZza3QT
 ZHmYvEgjg2QvdajaW0xNNpiJr_SLK5Qwcmpa.s2pQOTRx_g9IUv0SG6wfJXyARSQrhNSMlMuB4Vk
 KL18L8jhHI0BdTsv9uQNQ.mGNhphfAHkApCTJ_3oumuMqr79pxEadlS28QosMTvQiCBg9BCwcnFU
 xP267eXvqlLgNilToA4EiGmWGaORW4btt7P3zi7rKQzvB0EqACMC3THjx3UTi9nQOxHR2lRyL9bb
 1WZunhUBtmCqCQpmBnYh05ewUoqLeBnTkkq4AUYXG2XGrSDWQe6oQNPnGU2GR7JgTvJbkSbN9R8s
 D4ennHpg_Alzg3bWR7YCyKPgFFike0Gbgdkehi6NmD4cTT6HlGjwHESb5uvueLp0.cy.zHjvXKdS
 y2Judqid.xrBFu23tKH4p.7ilLgn9PRc_0eWppv0yf9ZaovPNPdU.VdYBn4lxPV6TT_l9xSq4obp
 vd.vJ8U275ant3VAOZNlJ6H2dV79hay8RNMWXpU9SbTmPHZfND7ix6c_dd8taCtHgppQWH0apUBV
 iEScS_a7f1b2iq2.sCna_cJ.8FmWrv6hgEInUTnPrcpNt9MBWAu0d65XPDV3s.9IzDUj5eraVFJt
 I33TMPZunmfZn3_giq3DAfJJPuxni0LnBp5b0DlnLVMfRsTZhkb_ys1L9VPpaaPk5NeOpwJm1.ma
 Fms7WXQ4n9HibJ1kg9UM-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Mar 2023 17:13:51 +0000
Received: by hermes--production-ne1-7688d778d7-l5k5m (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2ada3e063c3db3053feeb0e87bb880c6;
          Tue, 07 Mar 2023 17:13:49 +0000 (UTC)
Message-ID: <c5a11d40-9081-dfad-3d5a-7d46ba764dd5@schaufler-ca.com>
Date:   Tue, 7 Mar 2023 09:13:48 -0800
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
        DKIM_VALID,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/2023 3:56 AM, Mickaël Salaün wrote:
> Let's say an LSM need to pass a file descriptor instead of a text
> value. Would that be possible or would it need to use another interface?

You could use this interface. LSM_ATTR_MAGICFD would have a
ctx_len = sizeof(fd) and the value in ctx. The underlying
plumbing is another matter entirely. It's likely you'd need
to provide more information in the ctx than the fd, but I
couldn't say what it would be, and I won't speculate.

I would not advocate such a use, as I am not now nor have
ever been a fan of passed file descriptors.

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
