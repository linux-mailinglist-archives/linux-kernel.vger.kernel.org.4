Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D314A64FED9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 13:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiLRMRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 07:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiLRMRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 07:17:31 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807BF9FFC;
        Sun, 18 Dec 2022 04:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1671365842; bh=XSJZQSBOsi4d0bAoKp7CaBEEiAwUVRWvKYztM60uOnI=;
        h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
        b=ODKyMJFUsch+gTUWSJEombrOfdlTrAg3jA+WsOVeRjl+yB0XvHfwSgxaqunpwh292
         V8dv6Lv98BDkK0HLp/qDGJakBqU7Z3ymt9YumhU+w8eMf7SSutklriQWf17MMEoM03
         VhtEhyA+bcCRBcciZIdVL5vwb3+FovloEHLekWJECqvr3R+j92xM75pnT+DzGFVgci
         mak4SnxOu8cbsFxOmPW7b1I67aDm2+k8TppOlQD0O/B6mqY37/d1hG/qukUf04Ff4Z
         WIMNhJ9sA1yi/kJA9x676WPrOOIHO006hXjKI9zi7VOiKBuVHu5BU/xZaxyz6/uvXS
         75Znr1for0nNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.135.7.124] ([89.245.113.112]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJE2D-1pLXB30LOd-00Kcnd; Sun, 18
 Dec 2022 13:17:22 +0100
Message-ID: <dad11455-94e1-4b8c-d382-7100f08cd896@gmx.net>
Date:   Sun, 18 Dec 2022 13:17:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To:     perry.yuan@amd.com
Cc:     Alexander.Deucher@amd.com, Deepak.Sharma@amd.com, Li.Meng@amd.com,
        Mario.Limonciello@amd.com, Nathan.Fontenot@amd.com,
        Shimmer.Huang@amd.com, Xiaojian.Du@amd.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, ray.huang@amd.com,
        viresh.kumar@linaro.org, wyes.karny@amd.com
References: <20221208111852.386731-9-perry.yuan@amd.com>
Subject: Re: [PATCH v7 08/13] cpufreq: amd-pstate: add frequency dynamic boost
 sysfs control
Content-Language: de-DE
From:   Thomas Koch <linrunner@gmx.net>
In-Reply-To: <20221208111852.386731-9-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HHp7xb9naCA/Og7wFQa8uywCwZ/e5qFDv7qgmjsDWSfQvmuUXND
 je4hJP3Edz2Ru/nALLMowbfCDo45zrttm5r8AyRheUNP81TnE3Yz0osKZUWRBxRc+pwaIvD
 AjFPXL2EJs/OmUW3QCkiyFXb3PtvGBrsdpqANd+cwwaxtTxl6KlXKK1zJQL+l63ixD/sXWP
 4LtvZxlx1w5yWD/GmEr2w==
UI-OutboundReport: notjunk:1;M01:P0:NBbGoEkYW/o=;A2hfG0T/RjElhLwOxwGsLnxYEX3
 i0WITTC7MOjyDWk6E6AgL4PMjcfGMCsZLa5T80m9U8exjuMCRZbeAeHCvYFzKwAVbN01B84jV
 SC6AKH4JfD3xUfEcS9m0lnthv+C0bNAVp3d6DmK4wdkWJECBBMPiDb01a2eoGIOA6cdKMyz9E
 zek6/Lx+y63+Uv1PA8p+iN0AVGOPbd9e/6/soi4w+w1MG91JyNI8h9DSsKxymHBWhXI1NQ23/
 riJXAj2I7Ttq+trVRHJ5bxy6osr2/2g+6ZQ9EFzAXtdXF9Cl52KF+6jY7P2w6oLM3xpk7dmtZ
 smnGvVxXvkrUXPCYdHTZTGChuOzojzto6SHsg7cfoPSElm/RNRa66rvq6i3PvIhgkYuDfBWP0
 ISx2VZrSab4jqeNIx+mD5EfEDJhqrcfzWjMi9Wr9ZAwckpRPeRToKpcI3NvDODiiYXt12t68v
 ARPh8BziYbTBTPRPXLeC7lpnsAPpIuxjsxCuiBwstkp4VdtVM1fANBUhEsaAqmCwu4TLEab7Q
 kxAV8aWfOFVG10NDHk+wQhwXwRjgvZpKGXLj9w1pp+I+fOQDkGIaTs+T2EUGxIFxJYzCRhVpb
 0/aQ1tEfkA3y/At+jiiYXPX3Pi/07rP+zkQ0UBnbREm/yTKPet/JQy0J7zoJpnBVaxF5TkHty
 ME6eKH29AA2VgfBT+yfN8am7VaKgKUtfts2IG1ITpmo2s6PXxCQ5C9ABs2eQDijbWcN5InSsg
 2F2z/BAhsakU30C2YcREBCaratd9iTJvDundidD+NZvfMxVTWyGWlyzg+s/+7mLgFuidOOV5S
 /O2hporky5QdarAYJbYQKcgs8Wm7fJYC8ZXjRIOMk1nmDq0ywFU8/wOsJ13Uy0gy7lRhC2y95
 D8nOLA21ipi7RtRA+0HVWUnsD66sqZMEEr28rMutZVxtqABNLzJ+OVIz1ALZkgPCqtj2cblg1
 imBY8g==
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Perry,

in amd_pstate active mode, where is the equivalent to
/sys/devices/system/cpu/cpufreq/boost?

Is it /sys/devices/system/cpu/amd-pstate/cppc_dynamic_boost or something
else?

=2D-
Freundliche Gr=C3=BC=C3=9Fe / Kind regards,
Thomas Koch

Mail : linrunner@gmx.net
Web  : https://linrunner.de/tlp
