Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75342712BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237577AbjEZRfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242084AbjEZRfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:35:38 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A3019A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:35:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id ffacd0b85a97d-30a8fa6e6fcso665462f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685122535; x=1687714535;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWfAX3wP0d/3WFj3wkMH7vLqftqTMpkK6w5fJ1VRa64=;
        b=KWQV+16YSuoqhW4grf/1UpmnF7XLDLv5j2W30dvJhCHYgzgCBoYSO2ew0an+MGMEMP
         HcLzfxTeJvAUkBBec0cGTnRCy4OqCZn0lg2e1sx11Nhe/V3OKwX0kZSINUxXc+KvVjdA
         v1NaX5SxQPnmkBiEwR5c7FF9SW80egju4JlKqspdNOa7+1XwZIG1pSmju3WHYO7uEd7q
         V7si0Bto8TLOvBYJJ1OHw4MyKAB9uLa/cMqqW84tmpBHr4jtdJCurtprwyDqjDau9hqL
         FTYtg3x1f/UV5en96BiQnf23lJ4CRlIA7kT6P+7OR51nIOZ/K/pUDqJUJuYYlTazwNzm
         ptPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685122535; x=1687714535;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWfAX3wP0d/3WFj3wkMH7vLqftqTMpkK6w5fJ1VRa64=;
        b=jQoNXdzcIQ3+qsoKV4mAleWAhS32d91Te+xTc0aXH4kXYd0Hvf+zISZlLOawITD9aU
         YMWix4L5qixkDPe3GkS2e2ZVe917LnmsWrdZdHDpJtga5miI/tQTre4WXmfoF7SUqLJD
         SL+ORqwI5D9kt73GVwvrYifrcoxxrf2QhykIX3ui30G1mIohB5HItmWnTVQoIgE//+TX
         kdzeEqn/0M8K7FjpzyAIh6jHhTar2FFd5nqtZjKuuUTP49H0ujvADdvCbeNHHP0Yt7/p
         ZlbbcrSgUgh8IpTQLKY49FDMr2Mk+BgR+lG9GAdxI/NzCWETGA3yMGpV/5ewEd0IikN7
         ZgZg==
X-Gm-Message-State: AC+VfDwVCJwn2PA4LkrJfEfFzax5+tiwDlGnaAiLlkKLIJq2MM8tY3KR
        keaFXPf2kNg+PzlIzmhVVg+2TZqtJGf5WXn3J8s=
X-Google-Smtp-Source: ACHHUZ4fFiAuYjlspXSXVi634NiHuUB9cRfffGi10rf/WfS9KVRTyqgh2xwjN06N37ftirZEYJ5PXSMHnrgo2aiKGrc=
X-Received: by 2002:a5d:6545:0:b0:309:1c89:c618 with SMTP id
 z5-20020a5d6545000000b003091c89c618mr1827915wrv.56.1685122534584; Fri, 26 May
 2023 10:35:34 -0700 (PDT)
MIME-Version: 1.0
Sender: so623467@gmail.com
Received: by 2002:a5d:40cf:0:b0:309:5a9b:c10b with HTTP; Fri, 26 May 2023
 10:35:33 -0700 (PDT)
From:   Sophia Erick <sdltdkggl3455@gmail.com>
Date:   Fri, 26 May 2023 19:35:33 +0200
X-Google-Sender-Auth: gZsUoWBRLzGb100a6TBgZMeQvWo
Message-ID: <CAHrira-zh8SkjnQKuNc8ksxoMhW_jTjWv6bUD028_VobrvLOqQ@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HK_RANDOM_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please forgive me for stressing you with my predicaments as I directly
believe that you will be honest to fulfill my final wish before i die.

I am Mrs.Sophia Erick, and i was Diagnosed with Cancer about 2 years
ago, before i go for a surgery i have to do this by helping the
Orphanages home, Motherless babies home, less privileged and disable
citizens and widows around the world,

So If you are interested to fulfill my final wish by using the sum of
$ 11,000,000.00, to help them as I mentioned, kindly get back to me
for more information on how the fund will be transferred to your
account.

Sincerely Mrs. Sophia Erick.
