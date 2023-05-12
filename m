Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A268770017F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240232AbjELH2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240205AbjELH2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:28:09 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EED149C0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 00:27:42 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50b37f3e664so16892324a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 00:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683876461; x=1686468461;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56U3L/n2SWLavdhRRg0Yc0+2596Qz1l4ZkRdkLejoUU=;
        b=PIdKTOruLsLDNNWSLYaAaddRnuhpzU71B5JcQJSoPtO/X4Ug2hmXqrq6s5XFk9W8ls
         iO5jF3jJAlM5zVE64ZqIeNPQtzNUKi/KqD3mzY0dVYJButFAFrtwgaRL7ehuKcNOUM2U
         WpziumjhAjKmrnixEEj6z9WPuWzuYhNYcUHe3VRSQpadkwHTd1oiMRUwX0F7o1KhpTlz
         b3WW2JwRtEuj0wrPkLb8DApF4Ju5pzJDJGnA0ke6xrRYrxNWneR4fgeYhlEU24VBWojl
         3el7iKq6kxyM7dJKBQjd+Ri/tcQ3FbyTbY7M+HFFw1SoDbmW/loc0CLECGbMKIy4fSLN
         /H/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683876461; x=1686468461;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56U3L/n2SWLavdhRRg0Yc0+2596Qz1l4ZkRdkLejoUU=;
        b=A1qCgy2QpxSjb/8w6migsjfyE3otiRLlD4yqLVXmti/HtchXF8xFiMIjHvhduTT9BB
         5xyY+bYVBFDSfKIXPHM+XT3jo2C1V/a8R/kqC9iQgoJpaX3XvAn8z/j4EpJYLCflXHPK
         eYRYNSWg7QB5r1SsYFJHrDNDQ6+r4gbkBUmgzCWfViuboSZWnvndx2bRUvI04Su8tu/E
         41Uey3nZEl9oBnxRnhBfTQNHv+meFb6O+713AAv9nGMQIuu0ioImLChkhle8BUilwZbi
         ZOz8xgFHJg+mW9A7pd53ObJZeKac/1pRgFWtJmNlmh+1/9ixAbesFQLdwMh5BzQai1fF
         29RA==
X-Gm-Message-State: AC+VfDw3EIIGR2PZMYOpMNKUKS8UyrfdHU32t5XjiLCPjvdd9KIFZgxd
        Sgj0dqfq4jppsEv5lFf82DL/s19WSTa54rf/f8E=
X-Google-Smtp-Source: ACHHUZ6pcyHhNahkM1inE0lRaH/mZ24s5538GK1VAZQpi8JAPCD13bXG6sBJasbN3XNMuC2FzTMrFC9QWUY+FBWWtyU=
X-Received: by 2002:aa7:d286:0:b0:506:83fc:2dab with SMTP id
 w6-20020aa7d286000000b0050683fc2dabmr18316624edq.22.1683876460574; Fri, 12
 May 2023 00:27:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aa7:c556:0:b0:506:af22:20ea with HTTP; Fri, 12 May 2023
 00:27:38 -0700 (PDT)
Reply-To: westernuniont27@gmail.com
From:   westernunion <ezen99425@gmail.com>
Date:   Fri, 12 May 2023 08:27:38 +0100
Message-ID: <CAO_4fO8Hzm3FPb55at5Wizmf2bY_G7h4M5qya4fxuLAV2N8Tqg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Your overdue fund payment has been approved for payment via Western Union
Money Transfer. Get back to us now for your payment. Note, your Transaction
Code is: TG104110KY.
