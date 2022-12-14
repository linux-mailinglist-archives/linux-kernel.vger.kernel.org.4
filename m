Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6992A64D231
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiLNWNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLNWNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:13:49 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAD028E14
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1671056026; bh=vicrB952dHHvQY2TZFp0CXJmQ/sCAr/INTB321LfMgw=;
        h=X-UI-Sender-Class:Subject:From:Reply-To:To:Cc:Date;
        b=FcSo0divHQ1Om899zYcvXP+rishX65JQg1Q2QZ8eOrFB84uPnpkrvfuw4mPIxAJNu
         4836GsFgrh+3ZRjLnEX+t4m9P2UMJS27WOFrn2HUWzyRL+/dwDjGMrjkA8u8so6s3v
         eWCCvMlCoW/2R4XmKbVB6jvqed6GGZKOa3RhDM3DSQjH91BeV+Z4l854ElyXr7tAbu
         tXBE8G+1XVZsDAfVw+EScpd+zwBNv15H/QyvauF6yRGRxv/V3m1xqdCNcZelBL5KXO
         b0vBJoVg/QxF9mqH3Rd4usTfGJKNZA4ue3JA3UTzM5FrtgMqMXF/qHZD7331EK1iHd
         3N5o60FzRHoCg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([176.198.191.160]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjxeO-1od9181MQC-00kLmI; Wed, 14
 Dec 2022 23:13:46 +0100
Message-ID: <d1e6c74c9ea1fff0a8f900e8b55690f145e80878.camel@web.de>
Subject: Re: [git pull] drm for 6.2-rc1
From:   Bert Karwatzki <spasswolf@web.de>
Reply-To: "CAHk&#45;=whnOofeSoLu2wWN7H0GZQmdj6R_T0b8MavC1zLvgCUapA "@mail.gmail.com
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 14 Dec 2022 23:13:45 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2-1 
MIME-Version: 1.0
X-Provags-ID: V03:K1:zSRV2avXOTGLjNAMTef+0I9zht60kqAIiFGvkCjlw8taoKpGsoH
 dS07uNUSKd3QG2k/dxyhV5nnxK2nxkzW3Fy0NBrXkzwUb7UakCaPIYwtR2gjag7cvUQ2PxD
 lM0PLRAhQo4xpC5PEb94rSZ22SKz57fx6FoXohBRGFNdWCcJuDChEdxps0L7VIXevz1W4Eo
 M3mbh7POhfzM5F3edjVRQ==
UI-OutboundReport: notjunk:1;M01:P0:WUfm1qVKp2E=;ss5bJm5yQLC8ykPz9vnKJibwfyP
 f92XZdNlMuFYu1OavpdX6UPvP0o83VJ18pbn7V6Tb6Eu9k2peCpnpbCYUTWA9jE3ioTXkJ0Ka
 oXE4XUpl4KBZ7xvdHS+JHhx9YGTrmBfbfy3VZ2JyyfF1Jbaz1QsJpItaUK3cK8KStCyy0Chzm
 11nvCyW4w6yohn/lkmwaa+k2yW+Cmh7GTOmQ43epSEh+T0mcoKgzeuKTAQkPSlBCVLbtM9Ama
 bNEwmKQbYMxtMQfWOAKfzK3WnU/FbNHxdbg7cLB+doJYx3V0oIxwO1OoaVWEodRXvCqlRl4oN
 J17wJvVuC1WpwTQJJqff05NxfztFScJK3uDR8ValNoxKkG/ncOCknd0B9+UPz1kGaX5U64RBx
 i1aJycg3EDyS9T0yLowPuztzvzo1XvpE+FN3u/rpt34yDICwAhCbF5ETKEd/ikIaaXV380RHa
 XDzM8lsx2SSyeN5mSrMgc6qDGFJuPta+93ThjTIpAGhTI+Q0ysejHndkOOco9luVORauG3NGT
 rEawn8D4gFWNcjlFM0A/QSYmzwpeT9R3py93WCgZ7XQAxYjkeHcjkfXP2akjWncZXwDu4lk8l
 TO7qI3Ny5wd403Yd6FsQzgl4hTYlhrz/R8lDKeyAeamdm/iMQ9OTHJbKTxr+1n16msaevvNpL
 NA6+WYwD1zdBl14cMUySdbdvtnp7VZhEbfbwDgM39652NcT9u3kWLJwBtEMDgqSW5knPyd4g0
 DHdOE5ilwOqj8nQ+KQlXp2Ys5BdDX5Pyds7Y1SssAf4uN6wvBZM2kZE0lcRJY5tIQJ71qw3hJ
 bhXiPJjgfnKgNOUcTzWFwRPu5fZVrtXPafESeGe4i/uIsntR2PlYfIgZZ9TQpjrIF/ryNVXw0
 datdzIfXym5PcOjhA8k30BB2IQ7yc1KFnujGeWHpjBelmVkS2600YaPRfgOiG6PdahCp5xuqM
 pkwhdw==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The refcounting errors seems to be present here, too:

https://gitlab.freedesktop.org/drm/amd/-/issues/2281

Bert Karwatzki

