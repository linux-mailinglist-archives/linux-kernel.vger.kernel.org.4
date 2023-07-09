Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5D374C868
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 23:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjGIVaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 17:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjGIVaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 17:30:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2778123;
        Sun,  9 Jul 2023 14:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688938214; x=1689543014; i=rwarsow@gmx.de;
 bh=ZT2WA+hNiIdiSiTdYBj7HEV/czIf3ZM3McHFUNQUrCM=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=Xl2w0vT9IvFd2g+iJ5nVKwhS4m/ev4G6AL7hHQ2uOzsuJx3UabekCpDqHrwl5IaWaezSTzI
 9EXDTNPanvc8mJ3N4k6Bmuxmfe0ymjlLRIsuus61bANBKvKURQLYcxXIfwztAlGycHiS7UCGN
 j6e4oPPdchteApXvdzuqcPHvefJ8GUKO8WX98XAbx1VVcbMHTXQAf5KgQJ3PUgv9AYwaxUNg5
 iV+nd8SDFywLRPJ+HDo2JmsOSGeGwVT5jW7KkQOw8FNESWapBNCJdwtSOCuSVaLB+vvk++hzz
 +CkG2mEHOibVBZXS1R1wBcNV2x2ID0852ysSyLSTwSV8/fV37kTw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.75]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwQT9-1q22XD0Q1V-00sMr9; Sun, 09
 Jul 2023 23:30:14 +0200
Message-ID: <5ce87fd0-ae9a-fdb0-b237-c2e9a4e2dc0d@gmx.de>
Date:   Sun, 9 Jul 2023 23:30:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.4 0/6] 6.4.3-rc2 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Gikm1b9N8IjodK9weNTnTl1xdAIOjUC4AtakgrpPVUBE956F3v9
 Uit0YdzDjl1WUuQtBDe8v6SVrkFHTFwYiXOmXCSoCMSrn1D+DQMp4TJWm+NpDZHxM3yF94g
 9DIU/6n7DZoTII/irtg7OM8ipqQPGYSzkv6+LQ6ociosahUqh457fX+T6h7AeNVH0KL+gDV
 3O8y4ChOTXUZR/08yKBDg==
UI-OutboundReport: notjunk:1;M01:P0:7ulh2bVsGqs=;Z54mpYAFCn4Tn/IiaCjq7NN41fB
 C0jAutliA4Xb1vUApc5GcqQbyHc4oWjxLbK0ybYFHlH1mbQKUhFXoo2UrH05M83qddAWSfeBd
 6Rb2atpM1q5z9LSR4rc3A7oVwuyBeH+cLGYedc2uH0Y15ewRMEu/L7dtURy6x34Fe8Qw4L0Jn
 FAgFuT1Is1R4cmGT23+AsOHVJKkhuRvr6lLFwYOB6lf5s7APz2WMIOoeJOQz5NUhifkJoFAlq
 cQr0Mc9oY7rxAjlKEczYgPCBDD3PV62HDugBMIeTwb1rtyAKM7/WpEpc7XwbKN8+FzYteDnl4
 D46DyubcDG0wGjqhFhxYexSdLfyuiYbzfp7lOSRKCpBQAGZyx3xdOkqMMFwUclLibbork9pVZ
 oR8Qo9BusvPGhXxfkx4pDcE1d7SF4Djz3NzSQupJKDsoApdZwbtbZYxKEVV5zgeUiq3RF+k0J
 nJZUy7+BIta+/FUsfdBFyqR55aNiAFBLGtyaxIVR5GGhOsjQYFrFNgAtPXWHCenZCZu7Pikj4
 DVLzSRPssRwRioygEzYkMI2cAy3HDI5G1F+h7ySVyyUMgZ2fLfzBHnAwTOqLImU6xDsubN0Zo
 WDMWfaCn2uqfDAcrUVGAZOtJuFyRiCbyuhTYMuY81sO78ZY+Hq1VFNk2TsgNxCFvYlmflDGoR
 1mn3GFjHFOQBpJ+J3SUXa7zZK9pQqjY/VD2N/Dh6kwHUV9WDTVosOtzF8sMI3BZD0XmOXpdR7
 OnXeQeHEvM8Uz9FlaTmgtyYK7p+QRHOzTCG6KO/VUqnFzEqyeosAcPPKwPrFL1iAM2iKZ/B9e
 oiPprwTH4HGFHmFIKCbnJ920t8MugYJMOJeuzn5VNgayS34gJCF7b9+2UJ7k4l44awrygrb9S
 zmLxTDyjurnTpcxkkq+QzGgL1gNTMjP4cqyqSGcVLt/rpdDLmTMcx03kiPza2YNUVB2iByC/p
 ffSpTA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.4.3-rc2

compiles, boots and runs here on x86_64
(Intel Rocket Lake, i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>
