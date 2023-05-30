Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91129715E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjE3L7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjE3L7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:59:12 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0F7100
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:58:50 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2af189d323fso62376161fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685447926; x=1688039926;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uc+YHhTW9ICFHwYrhv9l/EYPXTKMjZFzUkqpAYd0Ud4=;
        b=Zk3LTrg4vMDDiiVlbZbXxqUykS7FOQQbbG8q+wFULwSZzra/zD5nOjA/B/ZTeVBfeD
         k2sKOg/d2vOaD/BSKeMzVxN2WL4aa8nyitZidf4+aUmt30QPShhfUHD49WthkHC347VL
         4uaZphLJ4vJLGLxO+TfRs0Bqi5pV402zRj9lSckM6bpw1uCsvVGwl910peoWNN1AiZe7
         m55F8Ae5Ej2oJ0Pj8/heN50dKNt3ZPV5P+C+N3NEKhlOO07146ipPoExo6J1GNs+VvQu
         kTCMN+bjszxzeb8iLmyKshaVSB4exiZEAxWkoYlFaxbTzJQ8eWgoc6QBjRbpDIMoNcLq
         GCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685447926; x=1688039926;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uc+YHhTW9ICFHwYrhv9l/EYPXTKMjZFzUkqpAYd0Ud4=;
        b=PTuTl7jfiwHiTc7+WcIOaNjPRQEdOg+a/RR6Zuv1FWhLtsxwCQ8DNaOYZvYriqB/xW
         QA9jqYlrBpD+U4cMkgGhhlZWdBE+eMJuBok8wfxLFN0cmTAPQZp2Yknfv9mAE59m2PhK
         cNB3l+6UkX9L+H/iK4/hYHr0xLtawcCe1qTQtF8BdrxAt0bi8fvscbJsHi83TjiKW7c0
         5Nb4vfRGUNpH7gUE8lNkO1KEuqtA4zOboO4/nkEmF1TYmb24eoxhSvRZeBHefFa3T83O
         pHX39zBpms5+5mNuk3zwcsL4IXNwygGfHPSb5Ez+YP44EENCLRASSg82P7QP5uH9jxI6
         s52Q==
X-Gm-Message-State: AC+VfDyht42BROQmYNRlic6hcN23Eo7pDYPb1WHxxMYX0hfYgqCep/XV
        ijsogJ6T82fo//D/6gHYL5KflJEFMcIa65jpobY=
X-Google-Smtp-Source: ACHHUZ52ku3UvgwpjSVAHCP5UIxhhc8SIzxFI0trKnaglh/EVVPnIxoedfR8ULBUP3b3RfqhMksyENN+2b5NjjGP6KM=
X-Received: by 2002:a2e:9304:0:b0:2ad:999b:3bd6 with SMTP id
 e4-20020a2e9304000000b002ad999b3bd6mr725739ljh.23.1685447926264; Tue, 30 May
 2023 04:58:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:3426:b0:263:eea5:5111 with HTTP; Tue, 30 May 2023
 04:58:45 -0700 (PDT)
Reply-To: wormer.amos@aol.com
From:   wormer Amos <rolsbaraye@gmail.com>
Date:   Tue, 30 May 2023 12:58:45 +0100
Message-ID: <CAGkCXQjf4SAp61MTCxa1oUWyFLvi7w6okNtO7vYVCWN3p-ybBw@mail.gmail.com>
Subject: Good Day
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:231 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [rolsbaraye[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dear? please i want to know if you're capable of handling business investment
project in
your country because i
need a serious business partnership with good background, kindly reply
me to discuss details immediately. i will appreciate you to contact me
on this same email?

Thanks and awaiting for your quick response,

Wormer??
