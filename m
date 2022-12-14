Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F26064D230
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiLNWMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLNWMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:12:08 -0500
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 14 Dec 2022 14:12:04 PST
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B874D1057D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1671055923; bh=vicrB952dHHvQY2TZFp0CXJmQ/sCAr/INTB321LfMgw=;
        h=X-UI-Sender-Class:Subject:From:Reply-To:To:Date;
        b=IJssX+ylyVTiEeBUCrYx1mNDhdkEjXPr9p8JJsFt7n9xVY963puXLKVRsRA9jrvLV
         21Qih05aLqWI5TGiikg8Fnrk3kbmVpPr05YeN99wFnXufbPRZvS5ITk/0TNNG4rRb6
         lcN3em7/mgJCqNsV32Geow1AulwQ10anZI7qL5jFGpmHfcNC6rizQH9IUZe9GdgAe0
         TA3je/2sR+QONmyQMdTeDmtmjW7UUmfyaCwecw03RWIsl8eFkOiULccQH8on9XjWPv
         56j2LnfPzgzJOg8HXbw8Ucy+x2Lk4gP9LzPugOh3BVlqRwX1HkegLbo+GIAJaJ70gU
         diF1rkj7koN+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([176.198.191.160]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MOm0x-1pHLdE1Rvj-00QFfi for
 <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 23:06:59 +0100
Message-ID: <43ffd361ecfc124af611e893c600d06893cae3ef.camel@web.de>
Subject: Re: [git pull] drm for 6.2-rc1
From:   Bert Karwatzki <spasswolf@web.de>
Reply-To: "CAHk&#45;=whnOofeSoLu2wWN7H0GZQmdj6R_T0b8MavC1zLvgCUapA"@mail.gmail.com
To:     linux-kernel@vger.kernel.org
Date:   Wed, 14 Dec 2022 23:06:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2-1 
MIME-Version: 1.0
X-Provags-ID: V03:K1:Oxze1YiMlhFHjYkXqil/1GTRqcQzWOL6DomfTLp8STEYjNCfMR7
 6dChs3CpIuH2jiJnHJBAh2D8WDxrT44L5iMkvbhpo2HkEu3kdUY0VOHshsOvV8RkT340auS
 TyDbNlCD7FHs8mZ4GEYzNFVZ5ybD4u07WY1uLsFzSD/iGrIvXDam4qZDzYCzRrRgXvgd9GO
 Ol8jfqjrRCmkhsyrN6yzg==
UI-OutboundReport: notjunk:1;M01:P0:HyHR6zzGsL0=;yBmv0mBj/FA02hcjDSq10VCXntU
 dCZWxUc44hHxyDzxxqG0w83U7zj1tpPuLTwETUXuTqG7Z1UOjxhfv9oA1ByldvBgtgL2kV93+
 OV2Vcxr5Al5Cn/tbhl4ovmx4lDT/I8eco4H6wZzuxlMvpDbT/mEf/ImWJM0lMkH17YLWgKa4c
 foedI5aWfIuNbJd1IiU7q5WPMjmBliwyg8jnr2BYKAKYzM5PPausSVg2FggWX2EoCaGJJ9qcm
 105O2G4cGcdEY42HuPbvXCfK45N4ZI/SU+rtCOr5+P9crM26vXT8UwPd3iS3RNlxjktOqPEzv
 J6zWSNfEcZY8HgcsH+u/mWTXDEOnloWMPCYC+PN8saFZPbs1Vgj0Az7MBLR+U3E2FJGSSLpIm
 lotVeb/K/Yvnzo8baCt3LQY8VWtGUD/YvPTogDcJ4wbhexPbgbA5KZ4ouLvt2Nfz71dFKf4gJ
 1QoMO6jqF/JWDSdV4w7Ftkqh/NjZi+uHkMk3YYZl9RROG6wtEio0o3DdGTwwcdFUSP9E5DIHD
 4AZK97/jBSGUSpw9IXWryFH42qpbP+e5oS53bIxhqijYQekFugaXvhYseRJvWejtvh9Sg/Y3F
 bZDiEwj9J6aGofZX4XWQKvynXac3EdMrzoknFuzrrUPm7XJZ544sIpXb/T2PzThUm0F4+4AS4
 M7fS7uogAW/9xO8yCK25C0wwkjzl3Bx9pCMV8AbwP1QqN+C3aVik6peF1bryhEpalFUs2+NXf
 /U2g8GrtWv+QUrx+ScmH3z1NT62l3ysSTK0R1Xxch8qiTcrObvAZCu/sWSNz+5YpIgTgsI1AI
 i1Ge58MkQ6UcldcZNIOZtALK7dRTmeWE/ZIjA7jfQmeJtOObYsEO1D1NzRgjfrIhXzrVEGpNo
 +guA9KXhYCzqyEx4NkFYctC7OFYLYY3Ub1J21owO4npJtlfww2Rr0AyoRTds8DhRkKgp6W5IO
 AW3fzk3+Dj9GIONyd+eYywtTMX4=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The refcounting errors seems to be present here, too:

https://gitlab.freedesktop.org/drm/amd/-/issues/2281

Bert Karwatzki
