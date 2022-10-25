Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE66360CEDA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbiJYOWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiJYOWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:22:10 -0400
Received: from sonic301-37.consmr.mail.ne1.yahoo.com (sonic301-37.consmr.mail.ne1.yahoo.com [66.163.184.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0D81116F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666707725; bh=vZ9vySslXRwOohJ2BpCmdCLuOq9WnUJGfn5bI4HwTH0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=aEqgRGZkdeEani63FxbI+gFQ4v8bYAvekZCm6v9XcggVl12bRxRNCzZS0KcXTG6JDr1oY/YcMZS0ZMsFQtnfyJO87kCS6NRflkffaROpF8VAUS2A3JnjRU9yDbNQ81un5PxAYLIvlOdQPumP6FWrr6vVwyP2H/ReK0zBRn9HL1yJPtrCPls+ERWu8DTZ275H6o0Rl70bo5XTehQ0R8XU04EK9kj52CDwpwq75gQCwIiOqG/TEoWoRCnOk+hLZ3+SRxr2RIBekS8SjGJcq4MFXPP2MBx3Xs5PkAhqUkURbwLoIcLLufDLHrOo/Hm8wndkAY3d5TOwwSU/+FuEv/mYfA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666707725; bh=el6t6dvjicKGEcQiExyibO5rPvCK4vYx5eKpyeIDglj=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=aSxGuyKZw4Yf7f3dw0FplozhnAQviUL8Rp5+peXsPWeRfzvMHvxmzREIdshtQ/s+TLMyZ6jL5T6OO007x0IlotKU9X8r396lDphVunudno7rVQATevjIFEnsg45v68dboCaNZCVywL53bS1zRIpOV5bGPq9cMYWJSI5RnR8GJfKvvsZ2N5wHsjt0aQQ8QyfDUtElRX6qhcAsDW7kAzjP6Q8zXwRr7adMGTOUTb0AmbFkuGB7TKox4OMyWI+HKmctvG4NeTN7G9Ph8StWhLZaVnPI4ADqfJV+7fgZhBginnim62EI0orsXrbwZeVCWCC7Eu/jro4AYsVrL8f+/4vSMA==
X-YMail-OSG: kDH004UVM1nBDSYdT4.B80rzIOkObdjTC0kSpcd1vbeg0X_zeXgPj0wCYc2tL.i
 KavHDov9RL_6d5WnYCWAahmVGYW5p0gZQYz3A5__JYD3iIJPLcJZvEACLSlMfGd0opHWSYnfVhOb
 tSelY1guKjr8lbMU3ro0hJC5i.jGiVUq6A9z15fSaJEDfbf5Z7v3UWDVcXUzdRigSnYmUSmvYPe.
 sOmV5N.CnquFjCjPcK68c_YwHQN9JTxINCkgM75Pig6eHJBio2Gixpx47ri_R85g5jFRm8L5N6mz
 aFuVxWU7moj.LjQhOYmgjWxSa767s5h1Bor7otqf458nGEiNCBj7E11pxbBpj72Y9z6i8KrhDCXT
 tVWL4HEh9KcCSlLigUYPTbkWDudUPci3ABD97rueSwiH76LXFqcgcL3RYcZmuhIp0xR2.UGbfvqJ
 u9x1YcDr42L9Gm9nimg66c.S1jI6PXOUTFKbcEcl5Gdg59mrjBE4rw9Wg4LoBI2Yw16qFbaYuIaq
 i2PcCX_NysXQo6oL0MOWvSGkNm.6KkDHj743A9._nJrkjaaVI59lozu98ICbLwPK.eVLNxcUneRO
 ciw5m_oIsfo0mx0UaK99VqeJoiybC6jXAMuxl4.osNExmS5BJL.CunvXLRex6B24jSQOIDX1Sg5t
 jFxpGYBDe.e5StQsynJ1cN94P7HbZXhdGAWA06qMHoeESZeKiXNQbRwiKzr0lvdGyNAMYR2vPXi9
 1hwklYgvP5irmTIw_TqUPLbXxyXisHYeOIqFCupVMc1xBvyhr7VB38MZHYZTXGuqmTu8frA2R0E7
 YrFTJCof.oPOlSJ2UqOa4.X2LixgY1XN7hLUTdzL0.VFTwKMLILT4Xwhehd_Y6S8hMb1DZ3Y65kL
 d14JH.mO8zhSkdScyg0Ilq08mfQ12mXmjY6ZdhjH7Bet6e6Hm64j1UUPMXd0xWnXaiIP_tyO9J4k
 3ffYzwgWV4om2dpFvrlhSp0D1sNe1CtEHaBNj6xTT5NQ99eZUGPGeoSxIMRql.IRc3_eh8q.wzo7
 fiHCgKD4WmLAe0h9X36Ztc4zRTOu4vT3LONIE9NuEA5IyU0N.f2_IUBK1U2.kaTPef0QCjxoOdLR
 fcCiXrjWsmWMiTWglBwSOQ7umiYN6BjwzhsaH2Ztz9bvVaU7yL98Stxjz.f0Bir5_fKgMpKj0nAp
 eVHxNTZD7CY.ZoWvH3WRQPFWoXLwlkpScHzpgXcNChOqt.Dz6G40i.LB1cztB.UTFO60H0dtDK0k
 otha_rzgW.HRVTULRoF78hzZAXCLUiECB2aAlmMHLWgbhbVW1CIR4qjKNw0foaAtdfSeQUS6gQqO
 .phWdoVBVDMhQ_Lj7w.0AzA.KYH4VR3JRQc0CKjYvwqkbAAbbg7Cq..wzenauu7orEc2dxcvD4DN
 mH0m0ZguUxo9x5AKBfyBhMoThMkDhKkHxkwPrWj62BJOa5_j8UVPjc.TvmzaPmZCr0j55MxDQZ83
 BarS9CFwbvHM0sMCacy5_eLkOyG7RFr7.PkZTNqwDDBdy.ddi6biMlUC.tecQ3_6LrVh4hV19Iar
 CV05slNIiNglIuYEYpPT1q9UwwU1.JByaHohl4WYdyDwPZzQaYRhY0xEzCOtbMrJYohxtWKZAuJu
 iu_Z3jD6HBLy8CVen9NDj1U3NdcAjrLcGEhvNmqInTrjCzG9BkWA.ToI7r2ZZNMewnuPRHVGctDW
 aH4L8p3e9cz.6UvbNijdRhSyh8BnV2Ww8Mudii_WExhc0lW9jfeS3SSHeSKiVS60LrdhdTDxvfNR
 V0_KP43_bqnOUw9El54PCmNRtb1KCcWFPfCIdkrJqWZm2GFwrTRD30RjAvoUIhhd.pRUUnRpixzC
 lS0TdGn6.N1YaLFFXJ90Q.z6sQt3Ed.6bggYA3ZTP.Mi9zv9eGWvu6xwlZGMyQKViqm0vGEcPtjV
 y3ZU3dryXjMliiPeZsLao4_4xFqESFUc5ZqjGIY31iXH_7Qae1glbxS2kf7YXEgJH1sCCCNVUDt.
 gjJjGqTzArEIvZmhhyQ_SjGXrtT4BZ.rDwfW3zemeqnh9Y3ShKr7vQSB0HCHb5T4GWxVe18JQW55
 bny7.Y_nU7niwfTuy1qbO8wtvqwMtg2n_Tl0pHDmukPGVf7f96yrNILlUsS4lYbCMe3ez08kBeyj
 9GaOuSONeWiNvTHLxIBKaoK13V0EGo4D0QLB4UHSBgaWcItl2gssPnAPoUKFhwpM7Yu_VkjCebq4
 Re4C1xQN.gK0d8IyY1_nwW_8z6bSCrae8OuCcYQM4ekXLimXZizwwP6FFbof3iMbSnz5JJTkA8hF
 Y5CxxAyd3KNgH3XZs.A--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 25 Oct 2022 14:22:05 +0000
Received: by hermes--production-gq1-754cb59848-dxw7w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4b402f20d25eef19a63a6cad4158a1ba;
          Tue, 25 Oct 2022 14:22:03 +0000 (UTC)
Message-ID: <190c3e92-6d3c-70e2-3a08-a0d3874ff607@schaufler-ca.com>
Date:   Tue, 25 Oct 2022 07:22:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] LSM: Remove obsoleted comments for security hooks
Content-Language: en-US
To:     Gaosheng Cui <cuigaosheng1@huawei.com>, paul@paul-moore.com,
        davem@davemloft.net, lucien.xin@gmail.com, omosnace@redhat.com,
        gnoack3000@gmail.com, mortonm@chromium.org, fred@cloudflare.com,
        cgzones@googlemail.com, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, casey@schaufler-ca.com
References: <20221025125744.2393200-1-cuigaosheng1@huawei.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20221025125744.2393200-1-cuigaosheng1@huawei.com>
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

On 10/25/2022 5:57 AM, Gaosheng Cui wrote:
> Remove the following obsoleted comments for security hooks:
>
> 1. sb_copy_data, the hook function has been removed since
> commit 5b4002391153 ("LSM: turn sb_eat_lsm_opts() into a method").
>
> 2. sb_parse_opts_str, the hook function has been removed since
> commit 757cbe597fe8 ("LSM: new method: ->sb_add_mnt_opt()").
>
> They are obsoleted comments, so remove them.
>
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  include/linux/lsm_hooks.h | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index fad93a6d5293..ef2e8a484798 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -136,15 +136,6 @@
>   *	@flags contains the mount flags.
>   *	@data contains the filesystem-specific data.
>   *	Return 0 if permission is granted.
> - * @sb_copy_data:
> - *	Allow mount option data to be copied prior to parsing by the filesystem,
> - *	so that the security module can extract security-specific mount
> - *	options cleanly (a filesystem may modify the data e.g. with strsep()).
> - *	This also allows the original mount data to be stripped of security-
> - *	specific options to avoid having to make filesystems aware of them.
> - *	@orig the original mount data copied from userspace.
> - *	@copy copied data which will be passed to the security module.
> - *	Returns 0 if the copy was successful.
>   * @sb_mnt_opts_compat:
>   *	Determine if the new mount options in @mnt_opts are allowed given
>   *	the existing mounted filesystem at @sb.
> @@ -180,10 +171,6 @@
>   *	Copy all security options from a given superblock to another
>   *	@oldsb old superblock which contain information to clone
>   *	@newsb new superblock which needs filled in
> - * @sb_parse_opts_str:
> - *	Parse a string of security data filling in the opts structure
> - *	@options string containing all mount options known by the LSM
> - *	@opts binary data structure usable by the LSM
>   * @move_mount:
>   *	Check permission before a mount is moved.
>   *	@from_path indicates the mount that is going to be moved.
