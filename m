Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3905F5F163A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 00:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiI3Wiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 18:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiI3Wiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:38:51 -0400
Received: from sonic304-25.consmr.mail.ne1.yahoo.com (sonic304-25.consmr.mail.ne1.yahoo.com [66.163.191.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88081B3A74
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1664577530; bh=ERtgRE4InN6kFs4Q16WOiF4jj0etNLf/Fl8uJDJyAzw=; h=Date:From:Subject:To:Cc:In-Reply-To:References:From:Subject:Reply-To; b=I+z/nKOsR/PPDNsNEbTdJPPARCKklChwfCNl1j2KlFoXbi5qrBVQwjtGZd9SGE5nV7V3RKT15k3r74XD5K9gv4ouAd014Sf89fsi9jTlDlP7BTOhI18SBg62woxSlR5QE03BaZHFqjxk5wKR0Lg48VyTEJxY/QacyoG7C4jSF0k=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664577530; bh=PEwfAgM8Qw4TmOLP8uO41WxxY8Ux0xk86dByKfZOppl=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=obAyoBfCEU/9KerjwYXh4CSjeA2vt9qS1DtpvB68C8kzOnVnnW8MBeDlTexqD0xdrrNhjC3izQO1puM4GCAFAF7SjZ9J7QA1SWxviClCTrm0soD+Vk23iRG4kRPT5oyhXPo5NrRsSX8b9k9d3z9wwAGlj2TW7JD04YXtVEoGNMgHG8nJEAxmoW0N0f8Y5yRiY6b5Xu4IzNufhtyKrB7cE43bh84ULHY/U5VaB5h1ZM2zSY/GVhPgb77wCmnzFfFSVZ82PAR7u0LIsQsab0n2Ey+YSAztDFpqeza7cXj+Cg3ArCAWgpSnM24m0tE7Dfp9o9j+FJXhl4c8mns+AoV2aQ==
X-YMail-OSG: wQXwh0IVM1nk8YQfH6hYvBkLsEPcSBA4eniy5X.tqa__9u1e7K.h0ffL2xuM18h
 1cUh_rJU3Ox1dRxwxfYKUvEOlge.YH.5dMnMDoywTKiM.CBG62kOzzMn6PYN8ajnKb2_0V39YniW
 1Ob4AbMfiHuOMU5GxrJP.a_KURgMz85Lf319iAWViJ5usbnk_ofysJ3_QZVF3YLKamCO3.kA1HXw
 HImf9Ysx4AiOIa09Ypc8OmuFRaqbfbBkGdsVVl__7H8e9d03VyrKj54I0pl.JIKOel0W4E5_4ua5
 G_2KcsNZtVyF7B_FSdVaqgHIkUgCTVZR59Vqxk7Yz2J7HW53NyUq05cbqIGaAcNcwE5_t5kBCCdY
 9Q3oa3.MSjbHjpbAJpnrwC2_8ucsPD0J6wwOedHPVCcUZDrHHbtK_4z9VSkyZ.OgSSEB1S8E4qbR
 YGROu6fLDmOQTlPZcXw0bXOaba0y_ZmMCn_FPb.hi4X.sUnp4UY8Q__OH8Ugqv_BMt2js5eRzNOU
 UxS6sLvybQm0ZYxWev_kySbxzQqCj6.W.V8YbbCqk42yCPkRSJ8QUCxAXSWQXKCtTgPMPkWaseJt
 X8KBzJ626ClXA.la9Q02OyC_TQuDrX.lQ9I4f_gVa0_Hlvan3NV7aa35lL.p4d.6qrV6MxWKCXcE
 EVgOEfFTSGjXArd5.1_ViESNx1ZTBwrF_3qiXjPYc0S46lMG39_KztaCGgiZPVWgKsbXjtnQxv2m
 YJoA9DIR3eGlTKeaw6Axf1rl85MhKjDNaojbVzME1L1MCNFxMZWvIYpSeJ_PNGpa_.8brX0NTjmG
 hL0bWJ7CDXsjclG7nozJcjAcUz4qH.hAA5290OMyiB_ybw9tdOp9XEfdJzR30bHOWemLPxr.igFK
 di6iSgMZ654Jr1h2tQc9LHwLPIqihzewt4tWG7Z4G3.NEyoD9mXojmWWdlFqJQs2sMfDwxcFlQ0a
 0CjP7mjUqhtnZ9KSp2qATSruhbHsy3df_iHMrKlKTTHEQfkKgEsyTcx7lsVn8TDBsOIhOHI3yRjS
 vuinwovRqu95HgSV75AJhMdStTeY405a4lC220Motij9TCi4MiioPZ.nmqsYiZMb8PQOhFMw8Y5k
 .0WKqHPmcyGu3c9OBeeJyGr1of0iVuRQf7sCrWi62KyMIQ8z5bPgWO41kIrjqyHnNk1FvzlRCNfL
 eDIqVlHrHBJRnzZBymFRqgRgKgNCbyP1O5szKVmp9NLwHhdDhI4gwrC4aGFLyma_qXZzKh4L6.VA
 0u3StnSjGbr47w1n6r0hAhdCr_n20EMRC2Irg08LkCb95PuloELdoUBOuuZC.NRr6QoviupFr2uj
 fzr1JLQXtnqSZHzQLbHluHm6NE0LxSGpfCbE4uO_OIjKWqiddSXUTrEgmhUawC0vrz0UH_aB.ULu
 SLP4i9sTXuuDnR.bfZ3e00Tnpdo3Ql4ApNwDALGwk03Gg9np9.IkyQoxQe0S2OrM1leovd6fiknA
 foH3MVzoseo.LG1eOpVmFCSK0bNlvn4g7UBHgi_2BEL5KxA6FRz5Z5jhfTrROOIIo_ktKYWNF_2.
 zCBEyjDFfaFScxQUlpeaBrlGwZI3AioTGe2S96oL_gjv2SShVT6orpjxwzo_V9DjdsCMOixRawsk
 K11uaZqce3AzFL6x_828OA8ir62UY9YB.GznA_TMscPC3ggkhIYXvDzQNXdGevM1QzVVIKaf12Bx
 c89iyLw6lRCj8D2gwIkMqhwEqR9m8KqIKhcFblZa0h8Kgwe5F8hvH2nxrj3cHhQA8GLS0bjml8AP
 A2AiPx6MPuaFq3IUe3ISHg3EoneaQeUVE4gyHvQHS1GXguh46.ejnOxUV6uxboRkFVb4pYGU.JDV
 HD8.pP5QYYf8HRni3vMKc_OkwXQsR6ktXPZFBhrZPYKqokzI5AekM_xTmdk3ezLDUv9GPJHA_M0E
 W1RTFkXY.ojlNM3wvzDMn6DStjQcTxSEERzKCvidu32zO2q0zn.46iijixLo9enG9dh3dMS6MoSH
 v9UIRGkc5qfWdDeSjYPb8zQNCN_8Qd9CBblRKFES1AEWM_eJodep7Le7.p2sQVqfq2axDnnuQ44x
 FFTSZaxP7Z1JdLgYx1WPywgC7TNnvZTflnxsX4g1wP8dN0OohMcXJjRDBJ7tx0PRErm2yXmnJdrx
 LvNAgg2M57IKZGT8YpqumFlWbABz9l_BLpfeB7G_.RvatCchYgO1RfCysYw3XOMXm11CeDzvXxbG
 Qpk7I8kaZ4tE0EBMBzBA46SI-
X-Sonic-MF: <pheonix.sja@att.net>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Fri, 30 Sep 2022 22:38:50 +0000
Received: by hermes--production-ne1-6944b4579f-dzb4f (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6624a487f903e240cc92ac933a633528;
          Fri, 30 Sep 2022 22:38:47 +0000 (UTC)
Date:   Fri, 30 Sep 2022 18:38:41 -0400
From:   Steven J Abner <pheonix.sja@att.net>
Subject: Re: [RFC PATCH 1/1] drm/amdgpu: Fix null-ptr-deref in
 amdgpu_device_fini_sw()
To:     Zhang Boyang <zhangboyang.id@gmail.com>
Cc:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Christian =?iso-8859-1?b?S/ZuaWc=?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        "David C . Rankin" <drankinatty@suddenlinkmail.com>
Message-Id: <H8O1JR.4SM4JR87O02A2@att.net>
In-Reply-To: <20220930214110.1074226-2-zhangboyang.id@gmail.com>
References: <20220930214110.1074226-1-zhangboyang.id@gmail.com>
        <20220930214110.1074226-2-zhangboyang.id@gmail.com>
X-Mailer: geary/3.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I had done more delving into this also, thankfully was not forgotten.
Additional info to solve blackout, was going to contact AMD:
The problem as far as I could trace occurs in amdgpu_psp.c in function 
psp_cmd_submit_buf().
Normal counter 'timeout' seems to use a max of about 400 with 
usleep_range(5, 80).
Under normal operation 'psp->fence_buf' will equal 'index' and drop 
from loop. I could not track what
fills the kernel buffer objects 'virtual' pointer's reference 
(psp->fence_buf). I assume that
it's to a firmware file that on read is returning an error, and getting 
stuck in a loop lock.
The error condition I found occurs when 'psp->fence_buf' does not equal 
'index',
breaking from loop with 'timeout' == 0.
Blackout seemed to be about 80% of reboots, but found that in 
reconfiguration of kernel,
on 5.18.19, with CONFIG_ATA_ACPI=y drops blackouts to about 30% of 
reboots. I have now avoided
all blackouts with addition of CONFIG_SATA_PMP=y (at least a week 
free?).
This is pure guess but, maybe the ARM PSP processor is dependent on 
libata procedures, one
of which causes a lock up some of the time.
Steve

On Fri, Sep 30, 2022 at 21:41, Zhang Boyang <zhangboyang.id@gmail.com> 
wrote:
> After amdgpu_device_init() failed, adev->reset_domain may be NULL. 
> Thus
> subsequent call to amdgpu_device_fini_sw() may result in 
> null-ptr-deref.
> 
> This patch fixes the problem by adding a NULL pointer check around the
> code of releasing adev->reset_domain in amdgpu_device_fini_sw().
> 
> Fixes: cfbb6b004744 ("drm/amdgpu: Rework reset domain to be 
> refcounted.")
> 
> Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
> Link: 
> https://lore.kernel.org/lkml/a8bce489-8ccc-aa95-3de6-f854e03ad557@suddenlinkmail.com/
> Link: https://lore.kernel.org/lkml/AT9WHR.3Z1T3VI9A2AQ3@att.net/
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index be7aff2d4a57..204daad06b32 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4021,8 +4021,10 @@ void amdgpu_device_fini_sw(struct 
> amdgpu_device *adev)
>  	if (adev->mman.discovery_bin)
>  		amdgpu_discovery_fini(adev);
> 
> -	amdgpu_reset_put_reset_domain(adev->reset_domain);
> -	adev->reset_domain = NULL;
> +	if (adev->reset_domain) {
> +		amdgpu_reset_put_reset_domain(adev->reset_domain);
> +		adev->reset_domain = NULL;
> +	}
> 
>  	kfree(adev->pci_state);
> 
> --
> 2.30.2
> 


