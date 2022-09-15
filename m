Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8235B9310
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiIOD3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiIOD3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:29:19 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08BC923DD
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 20:29:18 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id go34so39158493ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 20:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=aDnRL1ZmQxOMFMNGZoJPqBH20uB7idv9vdFa8r24GwU=;
        b=BIEvIqpeauLfLrfn2NJ3V9fmkkluSa7ifdKnINVa0FuH/hof7BYwLiLs7cfsH3OhAP
         9lxWsGd4vfMb9OtaXfZVslJ8FkD+73neujZgd2TfRD5FvJ2hrG9bfKDigpBlncmB7ftc
         syTeds4YHFgjZCiGi3+7pOn/jFMzXaIbGMfuhtERG5ytgwuRTnyIRCbCTLVvCED2xB+F
         juxn7WaE0qWoe1C4FEwd49qxVWWcHjOXpx1ieL0nu+409onKeh5K5A2kpwthXZ4xCU6u
         6oTpELQl8h0YfWzMrhCbRZSPoI1Qwr2iGFooqPqWbiPdp2ixAVkQaoXAnt6GlLbrUoLr
         k49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=aDnRL1ZmQxOMFMNGZoJPqBH20uB7idv9vdFa8r24GwU=;
        b=RqgErumh1u1C5aFb5Fk+InaNta6hnGY1COcUVagOkrh7fmxTVeWh6wpRSvlEI+yFJw
         qvr7KkVrpMMIqghpB6F5CWQVZdD47iWC8Cq3isWD4TuPjzoLaCxIwl0HnKoyE2U8SU1w
         PolJbgKXwut5MsW87kKl0QrnV49QZL1VsPcsmZnIuPKWctQTY3kJP9RWy+jawm95RVVf
         BH9MJs7wvcPuPoayTT3f1fbsHIce2dl73ekARiY6u+YYhhFLz+pyKqagOLLgJLiV6amZ
         Z1E32ZMG4YGY3rJ6wf7yx7FgkVytagg8GYunvu59bpaLc4oK0YTdiJH8tSRNYbrb5smb
         edOg==
X-Gm-Message-State: ACgBeo2A8BqfqSxM9tz2DyZDnnBz5bewMoTQbnEpf+DWJteuxL5cXWZP
        XAB1TeDAz0ulaoXD+Hkx+R0HETBXdF00fF2u0DM=
X-Google-Smtp-Source: AA6agR7aXCQraSLRzTTJb0s6HNgIEyTjp+ZsItD3EIMi4h7+yiD7fKo0eUZmXAkME0JnFfQl8HJpKSkV27vW9su/vsU=
X-Received: by 2002:a17:907:802:b0:73d:c710:943e with SMTP id
 wv2-20020a170907080200b0073dc710943emr27540333ejb.214.1663212557521; Wed, 14
 Sep 2022 20:29:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:a053:b0:24:3aff:af78 with HTTP; Wed, 14 Sep 2022
 20:29:16 -0700 (PDT)
Reply-To: ninacoulibaly04@hotmail.com
From:   nina coulibaly <coulibalynina107@gmail.com>
Date:   Thu, 15 Sep 2022 03:29:16 +0000
Message-ID: <CA+4vKanjRNwSyCTeKUeBt4hri7yqAWXqANTyX=mrkPsAsrfTAw@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.9 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:642 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6239]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [coulibalynina107[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [coulibalynina107[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [ninacoulibaly04[at]hotmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear,

Please grant me the permission to share important discussion with you.
I am looking forward to hearing from you at your earliest convenience.

Best Regards.

Mrs. Nina Coulibaly
