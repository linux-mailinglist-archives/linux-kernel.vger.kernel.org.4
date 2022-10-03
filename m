Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67F55F331F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 18:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJCQNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 12:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJCQNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 12:13:35 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B890D31ED4
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 09:13:33 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so6113796wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 09:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=wCtaWd9v4/NBog3l8CIR/fFSWktSHj6Kal4GrZ4+x+k=;
        b=E/d9NQ3BFasBlvemdDzG5H/TmIl6HYLPH8ygw5KzcdO/xOvJU2X3v6KaSDAoF+nAjA
         n4T9QhIDppWGUG2FH50IxAOojUqasy/tefNeUfh3km5/0XMf6AtHfMfBRuykkk1CuNk1
         EpV5/fDyWXtR0HG8lyz+IMJ5cO89aMpSq7HmbptTaM2IS+2HWlmdJT28TI731kIt4V9d
         KAoRwSimvUQH0lgrYd5VTzvXVM0C7M/hedWD7SFXIQzKtAPBt1Wue/bCVa+XM+OsrSIw
         j3Og3y1yhOxoT9kyVk+RZodA6LuPgB3Y9IO7JG53+eSMCEqQmGk6/ed3hEGThRi0zArv
         4m4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=wCtaWd9v4/NBog3l8CIR/fFSWktSHj6Kal4GrZ4+x+k=;
        b=FlGmmFF1tFN8hEN7TzHhaRQT6te/uHadLAdlRQQJ8KDBbQM3a4xvxnjHpJ4hufzjn5
         Ntp08+wf+R588CUkp7cp9UagpqG1VAZAXW0+oooYDsL2RYqWnhSSKYQR/NMV5C6F/Hr7
         35fcriZyBpAMFrNynZGpDaAMO552BvQiyf+iRhWVPAHZeyMGex8MANfoH8VzpVwBRupu
         ezK94dwlASFc30ousoi92IMEM8Csz9RV/qJyNJ6pxLYjgyi+M1BAoPZyhp0Q/psFnifo
         r0H5CppHEB4bPET9ssl1aE9t8EusmoyDZFr8lE9Vq9bVl2KP41IbEu2roPiU4GDRXbim
         YnTg==
X-Gm-Message-State: ACrzQf0kURtZT8Tv3Ei6B4M8Af1L38gHAOy4+eLVDV1QxTX8SQhHYJaG
        bm4sQ4PBfcbQdELx2Gy0V+NB+uqh1/YCeA==
X-Google-Smtp-Source: AMsMyM6leAyWd6eQvVmEx1/WgM2/TazUtw+yr6gzvTDqAgmUWi2mJBiuXrfaJh+90hgvBgUoNjOU8A==
X-Received: by 2002:a05:600c:4f53:b0:3b4:9aad:7845 with SMTP id m19-20020a05600c4f5300b003b49aad7845mr7442763wmq.159.1664813612220;
        Mon, 03 Oct 2022 09:13:32 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id v129-20020a1cac87000000b003a845621c5bsm12111335wme.34.2022.10.03.09.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 09:13:31 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     corbet@lwn.net, linux@leemhuis.info,
        konstantin@linuxfoundation.org, krzysztof.kozlowski@linaro.org,
        linux-doc@vger.kernel.org, joe@perches.com
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v4 0/2] Fixup instructions around mailing recipients
Date:   Mon,  3 Oct 2022 17:13:27 +0100
Message-Id: <20221003161329.431107-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V4:
- Change the subject line of the series
  Previous: Expand get_maintainer to be explicit about supporters
  https://lore.kernel.org/all/20220930064629.329514-1-bryan.odonoghue@linaro.org/t/

- Update get_maintainer.pl to return "maintainer" for both "S: Supported"
  and "S: Maintained" - Theodore Tso
  For the purposes of sending a patch whether or not the maintainer is
  listed as volunteer or paid is not really useful information.
  Listing both as "maintainer" is clearer the end user.

- Incorporate Krzysztof's list of recipients into
  Documentation/process/submitting-patches.rst.

- I didn't include the get_mainainter.pl example.
  Comments from both Akira and Joe suggest to me the example is not that
  useful.

- get_maintainer will no longer produce "supporter" so one could argue that
  the documentation shouldn't refer to supporters however not all of the
  potential output strings are documented and I've opted not to document
  "chief penguin" either.

  I'd like to focus on the particular case of supporters with some
  reasonable knock-on documentation tweaks for the obvious gaps we've
  identified in our discussion because "supporter" really means
  "maintainer" and you absolutely have to mail that person to get your
  patch into the right inbox.

V3:

- Drops change to get_maintainer.pl - Theodore
- Rewords around `get_maintainer --nogit-fallback` and gives an example

I think the document text now is clearer and should be more helpful to
others in getting their minimum submission list right every time.

V2:

https://lore.kernel.org/lkml/20220928003006.230103-1-bryan.odonoghue@linaro.org/T/#u

- Documentation/process
  Added in text to also make clear subsystem mailing list should be
  included - Krzysztof

- Changed get_maintainer.pl to print maintainer[supporter] or
  maintainer[volunteer] depending on MAINTAINERS file. - Thorsten/Bryan

- Choose supporter and volunteer instead of supported and volunteer
  Supporter and volunteer describe the role of the person whereas supported
  and volunteer would describe an activity and a role which isn't
  consistent. - Thorsten/Bryan

- I didn't change Documentation/process/5.Posting.rst
  This file doesn't mention get_maintainer.pl and I was mostly aiming to
  fixup the process around get_maintainer.pl. - Thorsten

- Myself and Thorsten discussed changing get_maintainer.pl, how it seems
  like a desirable thing to do but also that "it might break scripts for
  people" and it might.

  I don't know if get_maintainer.pl is or should be considered to be a
  stable interface and an explicit software contract but, making it clear a
  supporter is also a maintainer seems like the right thing to do from a
  transmission of information perspective.

  There is still the option of just updating Documentation/process in
  isolation.

V1:
- Sent a standalone change to Documentation/process stating
  get_maintainer.pl email addresses marked "supporter" should be included
  in a patch run.

Bryan O'Donoghue (2):
  get_maintainer: Print maintainer for S: Supported
  Documentation/process: Be more explicit about who to mail on patch
    submission

 Documentation/process/submitting-patches.rst | 4 +++-
 scripts/get_maintainer.pl                    | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.37.3

