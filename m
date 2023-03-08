Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22406B0753
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCHMlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjCHMlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:41:19 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A3ABCBB1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:41:10 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h14so15230073wru.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 04:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678279269;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kR8tWO1bqdzPwR+CyHIXGzui34xc8/chkF+wza09xWU=;
        b=QG6LXlNFfnft7i/QIKVvlf8v9OsNFn7+8xAKiVvhkikj8Nft1TV/nSnzcsCFeZg53o
         yhk0NU7Hy07dWpVBxHD4foWIJ0zMxKXWSQmpe1sI3lEtqJF/QdWFm8RWQh1FK1M+BIsZ
         zOW82lNiBlLVzJEDmWGmMpYe5GLpe8PAkbjuF87I0f1FYx3KH3mrsUBBN9NTg4wEk1yq
         RVf9uXSJp3KEdq4wac+ploVrdklATHfYOhlZZ0kvnJJtvo79i+WAHkXltKF/Ktg+GkCS
         EShKwtdscfC4UL4yXAJKWF75ZqSA2JGMVs2CyyrD16ggpz6BYQZDh8fQKDwFl6wwAgFa
         /FBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678279269;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kR8tWO1bqdzPwR+CyHIXGzui34xc8/chkF+wza09xWU=;
        b=aCIuAe8fm9XYyZee/wSQrPrePKwy+d7GTgySCHvSb7fl/hnlD6JeoghieKVtk1UO+L
         OD6+Cu46WLFYAALZxKEnanmkN5xss3u/ROLzYSn2MXGC4W+keaDVHdp9hCZnPyqBuBUm
         91FG8z80OP/CbNYhu4NOS3DF56PwGa0MT4lonLDfEoYBJP+0A67uzFT2AvSyURFlhbUY
         ApwT5KVdmfdEzrf6+ZIIzAhmnKmfOHPo+775VP1ry3KTSDv6xYl7hUcCpC3nrEuObKJi
         kfMS6VOu5UWs6Xo1keECSzh8MugFD88lE4UVmAiq9m8aGuuj/EyjVWRKCcQGQwpi+hPq
         oYzA==
X-Gm-Message-State: AO0yUKWER0GrEBRYNt6luIShsL0p+r1ivuxgK7DbNSuKlhNAI9/yzvz3
        IwXLqi8ncxY8Kf1VNW0Ye4Wfi1NeEtPAvX3h2wQ=
X-Google-Smtp-Source: AK7set83BkM4KnsY+ONEc5XNT4mKP1FJ+j04ErgrxABh2EnB/l5v+g8IQB/SE1tW0drQiC3dqVv2vMCeih5J6UftXQo=
X-Received: by 2002:adf:fd0b:0:b0:2c9:f41d:6200 with SMTP id
 e11-20020adffd0b000000b002c9f41d6200mr3415381wrr.4.1678279269260; Wed, 08 Mar
 2023 04:41:09 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:adf:f68a:0:b0:2c5:5249:8392 with HTTP; Wed, 8 Mar 2023
 04:41:08 -0800 (PST)
Reply-To: roselinekim200@gmail.com
From:   Roseline Kim <roselinekim001@gmail.com>
Date:   Wed, 8 Mar 2023 04:41:08 -0800
Message-ID: <CABgJjrDm86-xXwF4=+Vsutg2BqZDcrmveQa70Wj9tWUQPQdb7w@mail.gmail.com>
Subject: =?UTF-8?B?7JWM65286rCAIOuLueyLoOydhCDstpXrs7Xtlanri4jri6Qs?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:429 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [roselinekim001[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [roselinekim001[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [roselinekim200[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

7JWM65286rCAIOuLueyLoOydhCDstpXrs7Xtlanri4jri6QsDQrsoIDripQgUm9zZWxpbmUgS2lt
IOu2gOyduOyeheuLiOuLpC4g7KCA64qUIO2YhOyerCA1NuyEuCDsl6zshLHsnoXri4jri6QuDQrt
lYTrpqztlYDsl5Ag7J6F7JuQ7ZW0IOyeiOyWtOyalCwg7Jes67O0LCDqsIDriqXtlZjshLjsmpQN
CuyasOumrOulvCDsnITtlbQg7ZSE66Gc7KCd7Yq466W8IOyymOumrO2VmOq4sCDsnITtlbQ/IOyX
kCDsoIDsl5Dqsowg7Jew65297ZWY7Iut7Iuc7JikDQrsg4HshLgg7IKs7ZWt7J2ALg0K6rCQ7IKs
7ZW07JqUDQpNcnMuIE1ycy5Sb3NlbGluZSBLaW0NCg==
