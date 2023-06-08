Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C04472882D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbjFHTVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235941AbjFHTVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:21:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10497E50;
        Thu,  8 Jun 2023 12:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1686252015; x=1686856815; i=rwarsow@gmx.de;
 bh=0BsqEZ8AeUZZU5Rv4gzd6HuD/lO3oQ0x9OYg9EC3PeI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=ew5sebd4+ehWIjSAYkoqgROC4cSLR+/1E7k0MsQuOr0qGh3XC5KRFRqhCu0QnnvFi3rzVBm
 viQYX9rGOMrJaNAXU8dqxbAqYVLxWyuJQJNqvB8X0ptP+1K6GFfP1Vz7jRvIx38MdeRh+QFnN
 J+lJteoHifcMuV2Ph3vOBpOs+BcSeJGuBjCeilI2y9rNioTPGEY73oiIKx39bvQXcCjpjq8Y9
 DPAE2JfPq+pVJALBPFFYWZrRIAnZHle2uTN0mObDxn3Ny//a3+nV1TpAPS8IOlPN8FKfL+/ZN
 xm6rL97KaVOOxExq6PZ3OPILx716hG6QTB6vfa6jx1oTTgzOkPEQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([94.134.26.152]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFKGZ-1qMzLJ1AL3-00Fieg; Thu, 08
 Jun 2023 21:15:00 +0200
Message-ID: <3589716d-4f21-ddf6-7b8f-8aad0d67658e@gmx.de>
Date:   Thu, 8 Jun 2023 21:14:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.3 000/285] 6.3.7-rc2 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:T3yU0m5pNBW0i27IR/BXwNqamSuN7MJ1p3JBjBCDpEp/B5Ytkrz
 RXr3UFGStq3Pr1oIXXMtAxEipgw/Nzq+aS6DhyVcSdkeWaBkhNphV47jVTeJTQgR6XRGEL6
 EFsDqE65Gv4caHfnmbN0O20ir1rq2eNPusfA5oLEinlOjgsIotKrqIUx+h5meeKKp0sAc3j
 Js5SYsCJ3W+ykybdutnSQ==
UI-OutboundReport: notjunk:1;M01:P0:7y+1hLQkXPI=;KvWWOzVktbg4MiqeSaqbmcPIyCl
 pGXRhf9hYXOGNxQr7D0ZsTFU9HrrTaDE+0SV5jJqUF5dq4BDHk56L6kso1HZf+8nkRmm2nN4j
 /syorwKYiIghUYDENuK2557zauuyTrlzkuIKFhavTS0zprpmmgpJkfxkwjlOS16QbZtw78BWn
 BBWvbG7dYeQDat3eXJ1U0RCKe7hWo0DYfrovbhYaS8tOF+5sR73csic3TlR7YSNdnRvovrEOY
 dEUyCjtGvxoL8ZpijA9KPlEY8Gr96scf5qroNhr8n63HRo0E9yPvseQuOaanbRAm/QTarsfAI
 oQnJzTBc2zfPuVedbAamtD3HjmJId9qRpRg1m3FtPmsa+/yHCUSx3ZddSeTZdBRgYRJPNZS6F
 t8HGBwd7xY7u/aOaIK88cGBZ5G7dzLDHcYewUFgkX+02viGJXaYXyKhoK3PMSXEL8jdN8kxjc
 iIcFBKo2ErXmU8n+fVb/HQM47KAJuQKLriQdeVU4jMWvcEQ5uWILFJcaYVjOOOYninfWvW6WK
 sap+m0iwhxWR7+XRIUfpTh3FNWlpGmd7Nqc4OXRoRkjNZQxcCv/hq5xIwSCXrF0vAuHG4EjEk
 a3c2bVyPruTR2iTNyoEqJNyVK9DkEYk5Jb+8+grOh1c68CYZlMtZBhzdUfCdvIaby5Y3TvECP
 Ung3n0XMWkg7clYs1dtir/CfVrmhMF1XWtcawGmmpHFqODYvalPA0CSxtI+fWB5fC8U4rKHYI
 F+00nuUBySBN95eJB2zDvrrrYHxfcss+dDTpEbKgGot/aluc1/2d6+dLpTbUe7VSHGMvOtJk9
 Rgc6fhUOEBkHEoELfZF7xmReghTQGJS//Rqi7rdK0UAqarpJ+lbwozpQzAJ81NxRk9BVCb8DQ
 5HnewpAgLUS8uX9WBM8wQyElQqsZ1dV3rz1nU0a9foUJCf3dTl5lGk1xpcZwEC700S8Snjac4
 f3mhA4rKRqW9EJdlZ+Uf3ECKhqs=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_A1,FREEMAIL_FROM,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.3.7-rc2

compiles, boots and runs here on x86_64
(Intel Rocket Lake)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

