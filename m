Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D15630EF7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 14:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiKSNYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 08:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiKSNYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 08:24:36 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90C374CCE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 05:24:35 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id g7so12438834lfv.5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 05:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Th8lUdlp1ij/pn6iPr8J9IvlFxaIRpvlGZbvsAXJ1IE=;
        b=cw6UXLgofgXw0yvt+0/Z/AmwiDM3QB+NIHr+ZgBFD1Y1xxrTZXLxuKTJWa/DsMxitY
         OPIelEdBxxkNNOabfqmIZIO7aFPPm5/9N6wwU14gOfXDX6tD6lTe0Up2TJgt+4p/mZIc
         Z1VszIEzWBV8b79lvWFp1XllKQoNyaA4syL5NmnlITgAYSEpAi/4+WBiM/QMcBaC8AT8
         L/aq8UZWfuzrFihu3vguCnnrtrW5xNMViBI0rP2etvpfgxcHxtEdIV9nBe2iMUz/xmXm
         qaubFQbjMstlbH4wXol+FvkVdFyTsHCU8Oxv0beN+TlqLFXy30/XRATfB58KcEUVwB61
         tE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Th8lUdlp1ij/pn6iPr8J9IvlFxaIRpvlGZbvsAXJ1IE=;
        b=4oLKEIsF4Pfy7IQdylhxohwDg8Xxpavsk55+wJPiB8sAkQqgOwzALpMQJvqfVkUiEt
         m0h8GbIZhJgyJnXJ45OeZtnt/RYQxuMmx3kiPOUuTVuds6Cr74I2gb+jFyBRyfEvbFNc
         Ee7tHbgokODTNQVzO/LN1a3en/O1vcTUGjhzXc8Mrb9/en/E+OJexndHzsnYOiboHxHl
         vwdIIG1H35Mnk124PSlHlYpmd3397UHxy8e/sFv+qXQwI4Et8CwadWGp1dI0/tNgCUXE
         Omap8oUQRn7u1NKrhjFErk3UWw/tnn8AtCS+OUj1JFixOvTrgpeCgGD4t7QggJJtyrL/
         e/Sw==
X-Gm-Message-State: ANoB5pnwnrGxL0R7ituHWS+0tUlhNpAPHkNzfKF24or9kG7muGYS2Gbz
        jopSZUap21xcqgJfFvFFasqkpivCErURyrPDSX4=
X-Google-Smtp-Source: AA0mqf7K0ceVvc9k21Bmg4YKhRdYz4EDKyk5H1jeNPZ+p4c/d8K1i9aT1z2/tSBzwozgnoQ0EExWg65lGRKqd6LGMpg=
X-Received: by 2002:a05:6512:280e:b0:4a2:5154:ead9 with SMTP id
 cf14-20020a056512280e00b004a25154ead9mr3898117lfb.32.1668864273660; Sat, 19
 Nov 2022 05:24:33 -0800 (PST)
MIME-Version: 1.0
Sender: mrsohallatif20@gmail.com
Received: by 2002:a2e:7307:0:0:0:0:0 with HTTP; Sat, 19 Nov 2022 05:24:32
 -0800 (PST)
From:   H mimi m <mimih6474@gmail.com>
Date:   Sat, 19 Nov 2022 13:24:32 +0000
X-Google-Sender-Auth: jKOxRIwGq9G9lgtiQeFsAwfA72g
Message-ID: <CAP+WkJbgTQ+zxoWKpxhNOm=fRC1Y7RZw_w_DA9UDU4=RaHzZ=A@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you are interested to use the sum US$9,500,000.00 to help the
orphans around the world and invest it in your country, kindly get
back to me for more information

Warm
Regards,

Mrs.MIMI HASSAN  ABDUL MHAMMAD

2213
