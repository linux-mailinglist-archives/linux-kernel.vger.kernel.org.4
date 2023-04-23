Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14C56EBE6E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 12:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjDWKGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 06:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjDWKGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 06:06:33 -0400
Received: from sonic306-19.consmr.mail.ir2.yahoo.com (sonic306-19.consmr.mail.ir2.yahoo.com [77.238.176.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27687BF
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 03:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1682244389; bh=5pjubYAY/uRxOgObplB/laEbRdxxw0a2Ir9iuIUr8J4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=lhtWZWy1Dshb4wJtDq7Gqnd5GBv9nDQnQfRUd4zW+m9BR+g9cYdEAaGCVZjUyg8/bw9+HT+rFT0U1yJlPfJNbWfMGVXJ1jQwy9yfYj8iUXN9mC9TNVNM5CRmGh8NCwlB3iiDA+yABTY6JbMWWSB9N93kxq+QOSjGnNhbxmcs/JwhrRj1x49XDVqDfNYf/nktQbNQxEOL+irOif9xLE3OUpo8gXuEz0jMXsRGMQ4sFwYRbcy60E7Z5uGfXquvcr78omU0AjxmrvAbEQkQMoWuC3euKYp8xBwuoOTgqUnYnqlRMSSi7w9a94JVinsLN+3vvfUzbUySpmxG8OlQTQ9Nyg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682244389; bh=oTEtZRA5ug5WOPEiOjQNadoMx2KIhPzJOzaEDpElUsT=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=pW3g291rgLKqt6+acjM1JtXrP/wf0pPHXJlk/HBGSjSeBdxSsoRWecsq/yvPVSt6aze/GIcQGOVd6nOdndFGwT0wslQdejFV4gwXbaejJfCjdSZZNXFn85p6ZcN+xmfPKHOR2Fx6Bi5+6ZKshT9KMOg3W91gwbyiToHWIQ/cPQNAKaqkdH4W/H7QB725XloZts5P62ufMDyIoNvWdWcGLXKWA90On++z4EBwBrQzbxZMnXGL7ZGrJ6PhkJ+kvKW0d0PWq4mBwajeGIv1DMMPFIrO5OpwMyFSaFsdRhbgNVqAtoIlVVWoisOtC7/u2GAyGxAOyR0bTh+/4vjqfv1vQQ==
X-YMail-OSG: mL6UzEMVM1nExaUTdbwHCbe34ozNBP.4OPARC8SYAqajuV9R_cG6SFuqwJls4DB
 TIuNbc4Pvzk47Jb2smo5xKhdo7AuJOx_WzfLOCcDJSFclPvU4LOrqE7HTw.SLL6iAxigS7whE5fI
 RmatvvB09N8DN3dOmPpYCy6fbsCevxN9ebjMaYeSZQ3Lj25HXcV9l6QqOBvRif4pWsFXc3hBLJje
 YJU8AWykvh5sNVuIiNYSdtD1mvm1zy9NmwHszrMvg3V8haalyeOR1kdMGtETk8tMWxMTRB8dgNkc
 RKsa8DQEjCitUoUtN73zJoSN8vFLRMG8tMFAOQ38EaNmSsim3QFD2McOOCMnRqKLxmd.uhj7fSIG
 Bc5iDr0UA3qZhJQqwr4VNu6kIr_sJRKwqW0v4dxWnnBM59Pjto41MuTAFzqw2iO8sqAb8Fupondn
 r4l6sHrMvVn0I0cTrTPZ6pXuP01LSznPjU8PPzFesiznghtvNWTEZIqIdAHxxbEmh_WeeDgBRTNl
 GeoGeUbTnROjy7FXDXqgELcPdNvnDq05wjXuFUnfmgdtc_3yLYJ7is0veXA6vslMC551pi2hk5ug
 3UxIyd706p1kqNjgosw4DlLWhEPkgPfAirG3znQ_uM7E6yiZV68lo9XQ.vaPi5F6mwznpN0.XvFt
 QiFu75Nr_sJEZpw6bulCi3aWISMz0IBL_aCyyKyn5KuDiVKAL.Q_zXoE6uo_beJzuTApdkw3OcFp
 jxTdlT0GJYn94fBEEA5owD0yqXxKVUebakf4hZ3kWfDGNTrHgYjOih77rlOHPTQNOEYCRwmTgnGK
 K8SLRMY6G1qf2C2sGO0fmPbgEItr0Uu6VIdEPw3pbwJ56C.BLXhG978xTrsUam38mYAKAB6sh_I7
 7nWSEldn8X7HrcHDd5lTFRqofDxCMkkdWnLz2CaNuzhZwKSPH5BzG4Qg.0d6mM1gmOxmJfw6HNH8
 2cHNGY0KL0KS1X89XQD5I254TDondLrx0tQob1K6lsPNpcn7TK_6bwfM2TGEhBMRERTVP4ZQsjED
 E3_6SiH3r9BgGTyhgddn0r0Iwj5_9zxh0.coCOrEH.VKkT8U6Dj90eRTiuqhhBcutuvZFVsS6M0P
 rW4C9QxhqKYmqkluLPTe1z9g4fCKJLOg9yz4WeW4ojI27N4sQcw5QeOKoJYNuJ6QJRsf7QabtdSv
 ukwCr83pSQJxlnQuhsE_74wKx71q9CcgX4LPoNne.o1j5LQ4U5jIvAHnnDJYO77SclSK2wTO.ViN
 sgjV8t6lPGe9pViembUqPrsjIyeyI_5T5jBy8tQGGraxVVR9H.RUNvLsYV_FHwNWkEdvVhcv9X_k
 lCbtaFnM2I96yu_ko5cuEi1CHaaXq4CqC3fevcpAqpicqAwmcBPB1rCaeg17uc7GFFY_j0MLNjBG
 BSNVkKRU9IVANBQDzkg5m2tueTTvQ5YenJUlR3hK_ZpfWEhfVWftGMcj7D3AF6uXIYsCicIlWkAI
 4PzRVxPeAdTaL2vi2jkfew5iBw_dOnO_VQTm1VH04M4jImDgYS3os40xr2r0lwHbvQ2hiAPGhKpZ
 75R.bLPilrsv9P25cGMcYGhteiWKV8SHYiUDpWacHRnwQJyWsKtiyfhZjNa5gAbc9PUDWhc.QLDw
 CGaBkBm.gWYbvvQVWZOnJu.AO3OaBLhDndmEnVIJana2e4ZD_gzvPdBKPSRF_OoK7X_9t5LcOIgH
 TjV948H2QNfaEUmvAPEAMZ7WdmAP0bjTwmXMbEeGkwDuEX_gwdwI5Dn..FavDgUMY6Ujlg2K01HI
 4IKuP3cZKcsYYj4Bi_YFuUFW3.bPepByKYttQk4Fj9K6MbQDxKv53pTyZn0DEbiovqh4OfK8VAWs
 dn4pKOR9ct.f8oYngl_S7DS2P0Z2uwbcvTEG9KnSfgVCl3Qs2pAPAdY54YGXmhEMi.6Qn.3Rkah.
 u4UcpGR4xekdi4DJuOBVXCqhLQOkzVlPAwgjDDBT1eIvUOqoD4oiesyjt2IumIV1iCBeWAbig5nt
 UpslA3TcbY97DqrmZFR.hUlmcj1jxTCFSJUmkVGFYbuiOdPrus0qJ9gy0MVAbMLfd1rP2_2tKP2V
 BEAjl5bQ6G4sv81MV4Gfu7Zze2NWNBxEit0HSaBDsqsK_P2tkirfgzxgehlYt9Gv9hnJ5mrHxrz8
 O_NX6iTomuOMYazxGG7dUCnKklgZJNXglWp3DlNs3c5ZgBu1giFkQ.BWZ5w4CVMKFLEytd.x7acu
 _NgUukauPIwg8OhRD0uBVAmWzMOFpOzZ0UhMsu6i5uvIqeQ_eor_q2ck1gVMz0Sbm2nNHrU4JZh_
 d7c_l9_3KPLXfhJTYBQjT3PvkPckJ1w--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 39baf6d9-8f6f-4e9a-999f-207ab846cbef
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ir2.yahoo.com with HTTP; Sun, 23 Apr 2023 10:06:29 +0000
Received: by hermes--production-ir2-74cd8fc864-j696l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID cf55e9604defa8ed06dee28732abd972;
          Sun, 23 Apr 2023 09:55:54 +0000 (UTC)
Message-ID: <07c93b21-1c96-4bd4-9af2-53b76da14fde@rocketmail.com>
Date:   Sun, 23 Apr 2023 11:55:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 6/9] power: supply: rt5033_charger: Add RT5033 charger
 device driver
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <665d8906ea7b84e0a248315e8395a80007b8bafb.1681646904.git.jahau@rocketmail.com>
 <202304230924.lqgvPwZ0-lkp@intel.com>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <202304230924.lqgvPwZ0-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21365 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 23.04.23 03:22, kernel test robot wrote:
> Hi Jakob,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on lee-mfd/for-mfd-next]
> [also build test WARNING on next-20230421]
> [cannot apply to sre-power-supply/for-next broonie-regulator/for-next linus/master lee-mfd/for-mfd-fixes v6.3-rc7]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Jakob-Hauser/mfd-rt5033-Fix-chip-revision-readout/20230416-214502
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
> patch link:    https://lore.kernel.org/r/665d8906ea7b84e0a248315e8395a80007b8bafb.1681646904.git.jahau%40rocketmail.com
> patch subject: [PATCH v2 6/9] power: supply: rt5033_charger: Add RT5033 charger device driver
> config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20230423/202304230924.lqgvPwZ0-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/0fbd385f9a1acd55a8d943560428b9d783f8047f
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Jakob-Hauser/mfd-rt5033-Fix-chip-revision-readout/20230416-214502
>          git checkout 0fbd385f9a1acd55a8d943560428b9d783f8047f
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/xen/ drivers/power/supply/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202304230924.lqgvPwZ0-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/power/supply/rt5033_charger.c:26:10: warning: variable 'state' is uninitialized when used here [-Wuninitialized]
>                     return state;
>                            ^~~~~
>     drivers/power/supply/rt5033_charger.c:23:11: note: initialize the variable 'state' to silence this warning
>             int state;
>                      ^
>                       = 0
>     1 warning generated.
> 
> 
> vim +/state +26 drivers/power/supply/rt5033_charger.c
> 
>      18	
>      19	static int rt5033_get_charger_state(struct rt5033_charger *charger)
>      20	{
>      21		struct regmap *regmap = charger->rt5033->regmap;
>      22		unsigned int reg_data;
>      23		int state;
>      24	
>      25		if (!regmap)
>    > 26			return state;
>      27	
>      28		regmap_read(regmap, RT5033_REG_CHG_STAT, &reg_data);
>      29	
>      30		switch (reg_data & RT5033_CHG_STAT_MASK) {
>      31		case RT5033_CHG_STAT_DISCHARGING:
>      32			state = POWER_SUPPLY_STATUS_DISCHARGING;
>      33			break;
>      34		case RT5033_CHG_STAT_CHARGING:
>      35			state = POWER_SUPPLY_STATUS_CHARGING;
>      36			break;
>      37		case RT5033_CHG_STAT_FULL:
>      38			state = POWER_SUPPLY_STATUS_FULL;
>      39			break;
>      40		case RT5033_CHG_STAT_NOT_CHARGING:
>      41			state = POWER_SUPPLY_STATUS_NOT_CHARGING;
>      42			break;
>      43		default:
>      44			state = POWER_SUPPLY_STATUS_UNKNOWN;
>      45		}
>      46	
>      47		return state;
>      48	}
>      49	
> 

Here as well I'll change "return state;" into "return 
POWER_SUPPLY_STATUS_UNKNOWN;". If the driver fails to get the regmap, 
the status is "unknown".

Kind regards,
Jakob
