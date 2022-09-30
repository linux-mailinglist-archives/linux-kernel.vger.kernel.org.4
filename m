Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E073B5F0373
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 05:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiI3Dwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 23:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiI3Dws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 23:52:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB881E76BF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 20:52:47 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 130-20020a1c0288000000b003b494ffc00bso3755064wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 20:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date;
        bh=fU2FABDO9NxbrC/6cLEAO8gNFaIBYJLtiRiJYi+uc3Q=;
        b=aTmMjLEd6EeBqI6mC1o3Y9z1Culit0nfJYG37WdX9lI+PKHANPSYTtkp0RvHj7Iwt9
         qInzHTfttNuap7XqWtKn9z2voCOrEKJ2FVxA1Qt4V0qndCzwf8+xlQxGH3Khz3Kbs3l1
         7euq2QLETF4PluSHxrib8UWw/rkDaWnEFk6PTxsvlJIL/91StPEine8dn1rP8DkcEwfa
         IMPl8gEp3Qeqzs2+wezXYS+fx+oBVvgxyxTeRMHrS7jpT4MEAILgzWrLpeCH/ZjU18LF
         VIYHqH0T48/VRO0w0PnlpaCNhsfWVFpzfoSoGxGl0MO9/yqmm1q/NNbwG1H2qMExobzA
         yJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fU2FABDO9NxbrC/6cLEAO8gNFaIBYJLtiRiJYi+uc3Q=;
        b=N4BznBnlzj1PB8I+5JpzJCZVRgXvoOJtzZi84CnC7VtlLYSeGsGYRqjirihHlNvnds
         TxnQiDjPNIEgqDXgWpfEJAcZYm46lf4P+ALAnAdKhUkQrT1A7WQ8AJCoij7wXe2hHDj6
         qRZqKaaGxBpWxdOFK4OWoPJJ9a78GCJ/00jNfRKKbAPPpjWaEVC3kQdgYkNL0YkpC/7R
         7e+iITXW/KC45jRBkkYk+REQP/uIWrQ14t7LNL++fw2/LLPSEiUd2YL6Be3Xs/T5pvbV
         udiwDbcq3XadzH0zsxdiL/4YV4FTaJZazcmFe0/VQehk9WhHRASB1CLdEg1kzUfT+Y55
         pm0A==
X-Gm-Message-State: ACrzQf3tZXAu9F7kZ/qm4O6i6YXqZ11wWbWKDSP7mYMt6HKtXj9Zbmyg
        W0GnkPSXUN6ksZZioWRjGiOKQqWwrAKAyCz+4Kc=
X-Google-Smtp-Source: AMsMyM4kvUsCxCI4BqIbJ3yNAS0K24lawgzK3en8pimIEgEo8aO0TDicQcCxfR1aeUp7+uYFIl5uXvZ7iW+rFMHOlGk=
X-Received: by 2002:a05:600c:282:b0:3b4:76c8:da3c with SMTP id
 2-20020a05600c028200b003b476c8da3cmr4595664wmk.153.1664509966171; Thu, 29 Sep
 2022 20:52:46 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkaylama@gmail.com
Sender: ketouawale9088@gmail.com
Received: by 2002:a05:6020:ab15:b0:217:7206:6353 with HTTP; Thu, 29 Sep 2022
 20:52:45 -0700 (PDT)
From:   sgtkaylama <sgtkaylama@gmail.com>
Date:   Fri, 30 Sep 2022 03:52:45 +0000
X-Google-Sender-Auth: 7WglXOdD8x90Y4ha36k19APTllY
Message-ID: <CAL9nkAgCUqSUv=iovqKBY2ijdy43UiOxQsGi3uYqvJocoESa0Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RG9icsO9IGRlbiwgb2JkcsW+ZWxpIGpzdGUgbW9qZSBkdsSbIHDFmWVkY2hvesOtIHpwcsOhdnk/
DQo=
