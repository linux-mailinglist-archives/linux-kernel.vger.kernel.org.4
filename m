Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6CA61E2F0
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 16:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiKFPXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 10:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiKFPXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 10:23:06 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE9FB4B7;
        Sun,  6 Nov 2022 07:23:05 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id b2so7083921iof.12;
        Sun, 06 Nov 2022 07:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=44PsP8SOIiCswDT5K4o42rLEZaaZzQNbPBW6TrKP04o=;
        b=eyBa6JB/IDL26n9TDfnHoG882zJmEjN2bZTTDe6uIR3eI2eXIKA3n2VWURkHiFcIW9
         hvSWHB7Ert6GuouyQYL5oC6AOm1LBJaWfywu3WAXEnztdqCBvl1G42TRf257lLDyvVI4
         2EG6jehGGUQlkJDqv/rvT83pcrt2V/o1iZpbnnwygSvFOi2vFZsFVc2DB2aU672ejyya
         qbubbVKrs7ZIz1epdx7uhV9l5EfmtPQ7G9Um4dhyeVFtwa/hNqVuZrwsQr1jurn5uLVu
         1yP/BN4g2erUpIxYsQ6o9K7AGUsRJ4pDT5pW1gP4BZaXWWPV8uWBcUCIfX3ugqa807lO
         uWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=44PsP8SOIiCswDT5K4o42rLEZaaZzQNbPBW6TrKP04o=;
        b=QrmXHq57TOC8WfoHVWVYiRfCJFUkc36dag2bHOb0kMonKoOqPyTPO7C4+flUfWqIkp
         Ljj1LU6YiapIm5CasJlO1hsV818TPVqDxn1LUC79D9gShGMd67lQ7ug/Co4Us8SaUnse
         d6JTK7HEHJNmhe0puCl7q4BDoCdczhVKBwQcOtPNbKKyWhgQxUppZtA03vnmR8t3ygJH
         DmKO0XQPV4+GMeMDAqrkxqxDzUrcNXwLAIjn/fvQBR17P24CH4rUEMbXE8oDaTUN/fL5
         3qkgrMFH3qrWMuP7KNQg5H8py1GwOkViQxq1IM/9UZJbdUBOls8fz42Jjb9tSqfo5KDH
         ImAA==
X-Gm-Message-State: ACrzQf2XkFhWDD+rYWbUXSqsw1yXg1IhiKP0qj9TQSgPIuDRl009mzcT
        YzZTMwajE5K53B/o9X4UsmjpzGtQm+Dytd97PtA=
X-Google-Smtp-Source: AMsMyM4TNtRxx4c5y4g4E04hMXUCF9dxCC+dUpUWR2LSo2A5OrKyDeKlKMUh+T0AGh4BIthY5cMURJI13uCYBHEX39U=
X-Received: by 2002:a05:6638:204e:b0:375:94ad:5492 with SMTP id
 t14-20020a056638204e00b0037594ad5492mr8905676jaj.44.1667748184751; Sun, 06
 Nov 2022 07:23:04 -0800 (PST)
MIME-Version: 1.0
References: <20221031190159.1341027-1-lis8215@gmail.com> <W1FWKR.P26T1W42X3ND@crapouillou.net>
 <CAKNVLfaK+XOSzJLurv5pDobvFqS+jAiub4P6n0DgO5RpUnw-hg@mail.gmail.com>
In-Reply-To: <CAKNVLfaK+XOSzJLurv5pDobvFqS+jAiub4P6n0DgO5RpUnw-hg@mail.gmail.com>
From:   Siarhei Volkau <lis8215@gmail.com>
Date:   Sun, 6 Nov 2022 18:22:53 +0300
Message-ID: <CAKNVLfZfq2p1FGEFsTE3u3KtCnFZRL7Bh5SJH8BO_ZxaDZY8=A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Input: adc-joystick: add detachable devices support
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Not sure how to hide the real joystick device from libraries like SDL

Got it, EVIOCGRAB ioctl shall do the job.

Thank you all !

BR,
Siarhei
