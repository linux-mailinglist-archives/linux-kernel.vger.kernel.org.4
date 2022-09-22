Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFC25E56FB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 02:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiIVAHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 20:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiIVAH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 20:07:28 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68B6A6AEF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 17:07:27 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id t8-20020a9d5908000000b0063b41908168so5099620oth.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 17:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=d+EIuUmfXkEsKT2YNjQagsUmNpqExC1p28C7sIdNOnlcvS2azLWqYLQIYmwLxuC7Ro
         92gweJAjoVJhdwSRTP0pjmKgX35cfrWe5N0xGY3Wxq+Z+BNJ7dzFCvxJLnWEgVlS/wJU
         vY+dundowmxk557ov3mfkbQsAECeyKzbwBK57oK4CF3Zvoux2vvl7DPWhd0pRFi08qLK
         GqQ1YVysbRbQMK6B/eCFvvrCsvokBTuOZjwICdBEFeQQvhzJWwKzo+A0xB2My01PwS72
         CVvfF7HqMJCDiEiYCz3tjiG/o5KXHybBmOf0zZiPpCYToXBVEZRi9PUYPeIHI6nAy4O5
         JTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=FlCohfpQ5ncyGxVxrHixUR+44eaCXh5iRQeTayfZfA0gpu35gPvhl0rMwhXeTGovSq
         VktDO4Y01qQ2jilthAhfxd641VGsFMXx8STU8gPb1tiKP0lHJmR3sR9oxHcrSnFAO8tK
         L2k2vKhlHwuaqjahmjbIYuJ0koeGCFzVSUExobODfvf4TeQ5JJG1PG+vVuBOC2rXqmW6
         r4YDxTs5QGoAbJR2LobXVZlhDJSo+pYl7PRDXD9opEB5OAsqsoBF1B3PQsRROECWaZhI
         esnqxPwxe1eQR9wUFQPs0pMQckqNVjRqwHHeD/9aHHA51iNUNouihDAoxzpsPcIPgYJM
         bXpw==
X-Gm-Message-State: ACrzQf2n3YKQr64dbj0lHppYPKCTjwWnzZuDo5Xj5UMdfzb1IjD+5vC+
        zVbRQuyZuZImVkAjh4eK2Kdnj4I8BcXkO/jDavQ=
X-Google-Smtp-Source: AMsMyM5nUMnbw47qOZtHwEA3dPmHbEZWPnVXhqr5U3ldql0dDYDAfnw+xvVwBs83TWPapvaKEgSpzTwDiAQGcWT3h7E=
X-Received: by 2002:a05:6830:1642:b0:655:ade9:2a90 with SMTP id
 h2-20020a056830164200b00655ade92a90mr366051otr.19.1663805247314; Wed, 21 Sep
 2022 17:07:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6802:1e0d:0:0:0:0 with HTTP; Wed, 21 Sep 2022 17:07:27
 -0700 (PDT)
Reply-To: linadavid0089@gmail.com
From:   Lina David <tinaevan26@gmail.com>
Date:   Thu, 22 Sep 2022 01:07:27 +0100
Message-ID: <CACU_YNNoD9un0X2g0PXEivMn8cJc01DBPJO+_H9ZCNf0rB-HLw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:32b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tinaevan26[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [linadavid0089[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [tinaevan26[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,
how are you?
