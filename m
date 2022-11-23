Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE44636A98
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237107AbiKWULk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237228AbiKWULh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:11:37 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9598685A10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669234296; bh=GPbhQXdLb4Nphfn3/CvkY6ve9GsVdeScr9Qq0oBHf0A=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=eO5xY0X8eugtepvk5ipTg6HtsDgh74c6E04e2rGpkps13Z/e93dyjCEhnBKlp7Sq3HGvfX0PPqcNCGmHPTuh/oDhLF8MxEyetLgO5BCqIA40QtKxVEyutjkx7+8BVMe1Ezc9APYh+tyk3s1MeBlT+VYi2egua6tmkz1Bh/KP56yNyM/NoIcHglG2u5F+g1ydL9qd/lGA2GQeesUcqMeY0fw0HHEEUsoNQ54Vv1YxuUC2NLUGBYP+iXTthjKHsh0hODRtZlPVSeoGCjTkpO3kAuusCVUFAjwjhuYRh9v2FBncT1z9CA3hu1G8m9+5l43DUCWmzLH7ZUQDHoDeh+NdBw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669234296; bh=W5VC5x+DmOaW1uVjwoIm4gnA4RvcQfxNBtja2aSRyct=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=oGKrAfxPnzGopg4R3efLyoLgbWm9x1+YscSZWoiSMu5luxGH5SWi00qNGw72t0LWjfhz6d62RExkWZp/dNH2IvtcdnpcxDDQ7UqAkKabGQZAITqQ9sOeapZwVsvBZl/WbDxrXgNfz0n3+PTZPTg71H0Za4yqQ/8IGwLrm3Zh9RXE20vPYaz7SeRVlW9Rlmx/Dz6KFLcekchK1y4nk+wvIKwf5mrBBrbqTvdf7BUq76gIeq47Ekpg8mLYb8mL7G1irYSD0FbRZSnBTI5lieXPx5SwDUW+ltocgaPuqwEzU56A3WKFQoYrhtkUmv0Yhraf3cc26OpppxK/UfC1BD4GKg==
X-YMail-OSG: fH4wupsVM1nw.RHwvnKzkNBXpgifYSeYwYOSVPZ4dDLB6x4W8DIxyOuIc8K2hTe
 BomL2GBbR8D2DjK8outNFf5Ekmf9AI.roR4vErP7c7xK6UDIiVVXXFm47MetPRt3ss79Q6X1nUpO
 j9TAbAXVuh7VKUF8d46y5kgay9Eeu5iZpGm7KKHbSeIydgxcL8VhlhO2HYF0rHv5LH.qKyOdvSqj
 qO8URaQ4LF60ST9XUrKk9OB9MexgtAVnyYPxwo17AqRvatSzdPoEZ9J8I_UsNp8E3pS.OhoUmwOM
 eWY_8C5gPF1Yz8NEQnO_t5Vyamhzer2xrMiJJqWhkyvkCycZaExX9f8dI1_ZkMbKY_Qp1ilRfJZf
 RAnbRfmvziTSNKVtdaFDCR9jlVhfWMm17zno98zRIf_g5xUWSLL273y6Ekat.ToDWNRetnE2k0QZ
 laM5waB.srO6Sc8YwayyfMAZjBn.dwN3OiGR5QeUyNBZ1rbBTkZGm_WiLIbLjMu9dP2zh41yjedL
 nE0nQmy5iz3AvsvwOqtNKheDkeRkr3EGnVFQmqWqsZZH_9jjs_DnSe3nV4RKxtCLCkokfnMPZzlj
 fW046jJyZQErw5rAa3KxzHV0Swo8EPcBxiAPuk0RXYnV17EXFY2pnxGbncya7qTpxpH_X.KcuhIF
 Ydn._lLB99QVCSk6zOFesiII0oM75qAw4XYYp8ktdLSfHgbNTuWG.suXAMHxdYR3Sl9ZQkaSMY7b
 D43WQLLnuPgsTS._ydwn56DjLASADX3ZrovOGxxER8xdEQas16O9gjB0JEGpmMgDEVwft.k1nvPp
 wiYYyy7rpGDFv28poKkklsvCAKROgrJZKtjCRF6MzTrxkO4fyp4p25fe1_gJcoSAmHtlDrpzw4N8
 HqjOxr6fUin6p7LxRAdre9CkAAfGGnCVvkrBMArz65fz4uNacdpuonDIIQDEXANp6IUZ_ZZjp5J2
 j5e4S8MSgqABAvrSNfZjknpMjvLlZIJf9KS3kpLtIQvEtsob_c74.8m5z87Yf5cuU8xZ1e_0aUyz
 3fqn7k6W5TOdAeb9R8S4j6wUwJsMNR0IenjlQY_57hQi_r38Sgl7ObPWZCiWCxxuLeDkTUDu4kga
 JKZc6JllBynzwXZSRh0f2hnhALEzT3KGRz4GDLwfk_8KR8AHDWnrFOvHg2Gh9aiKfkrSbgfcmW0E
 YZEOZNQ_wnne9NGjYTgOX45v0xcP8hjfA7PPWltFcCqFitSpyaqM6jIn4DG1yEFcFaumQckAL0V4
 kkFESZvQKIIUC.yzNoXLCKXn1Yyud7gObcQXBdzkUgHCOC8EBLwXMKqYLloG0CNZODjPexU._UL1
 W.OkpMp7XeKJqNwiW9oRfYC2a2FsuS3DNW4qjei6F_pNW3EwPdSIybTeWB.KlKhwklr9hoWLiqQ9
 p4ubnQbkL0_2mKkp0XTZTI_mDwJ2UlTi7kQTmIHlCo1YTD1tMbhWIs5KcTEVh6ALLP0qM9GIsMbW
 VeMp41q7cKD43i7FNsTgLfMd.CAr4h66gnVe5t4gtCoy9C1mvslzBLOVEw55LR8AySQrvwE5gDg8
 SzO_b8QHL.1ilmT4jRJBGJ7qlIpeJKCGYIUuT3VaORTxv3OQhd8VSOOc1si9XlbkdEKYy79JLYIb
 zLsESF_VD4Z8aTqJu5GlyeGrYgzFtOWzef8uEaxR4jKrM0KubyOtDonRYIF0KKav.w86s9IAhmxh
 s81g.68bNMJWE9N.s3bVC.dLtf5I4e7pQOycsc.KFhnguTvyekrz0s_81EyIdPBTqxDNU6PiXGU5
 b2JnhhygP5IF.NU9d9wxums6GQMHeVen_7mOuX2pi.g6Z0HwoFnAovpD3cevyukPC0A63mmUbIyn
 joEG96m4L2h6ZoVYsP6VEoOQ4G7Pj_0Ehp0TC.U0Ob8qWgVYh0M7IFaqeSi3Tw68O8zNWH1t57pH
 OnuaAdIfg65iuwmetoUgtWsI3tlAKNLx29o2YtxoeU27S4dsEVeqtBuBOQkKpr8oa3p_Y.bY2f1u
 jnq3SjmjtK0VfHDEz62KjlnwMaweI_XBdiasu_ckJ3Uu8dtVUMvkCkhvBLfEE3uHMVviaw5EY6Xe
 .qPIbZme1HMX2VNo2yGgr30DDQzWZQE_GZOCxK_XaYHCHvkBHLHxB3HYT8E0.wUuAVR.j6l7RkLv
 xy1PFLVJVAw_24T7PFwROezEE8gKvr4vY6.2TvcUw1PDzkr.5v7DWRycey8G6fMMIqhktRQiTjYB
 HX5gBftMMFrlGxtVeU2eKYbwOvnWsrLvcNkguIL_R1Q--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 23 Nov 2022 20:11:36 +0000
Received: by hermes--production-gq1-579bc4bddd-kbwws (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e06ebf814d694ecbabbbaecbcfa7c6dc;
          Wed, 23 Nov 2022 20:11:32 +0000 (UTC)
Message-ID: <2ca28e79-4600-08fd-b38d-479ca14c8b18@schaufler-ca.com>
Date:   Wed, 23 Nov 2022 12:11:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v1 0/8] LSM: Two basic syscalls
Content-Language: en-US
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
References: <20221123195744.7738-1-casey.ref@schaufler-ca.com>
 <20221123195744.7738-1-casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20221123195744.7738-1-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20863 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/2022 11:57 AM, Casey Schaufler wrote:
> Add two system calls for the Linux Security Module ABI.

Whoops. Sorry for the spam. Test posting escape. Please ignore.

