Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAF7709738
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjESM1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjESM1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 08:27:19 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A401E19F
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 05:27:18 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-510eb980ce2so2375851a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 05:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684499237; x=1687091237;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=kJ/ZRACdVLn9r0YkQwWx2+S9UG3fDvUVAgXeZxdWcTwY1MEEQVOos7/3jTcBoPHRVQ
         boUaopDQYExnG5sSUBY+TC2CeZN4fGLko+Sc1i25gtVSxtpwj7cl7A9dKEQq7O03NiMS
         0PpdWb2riB+7NneVMIdQq2yZgu9JyZuUh+6m93AlOAcv/NKzA2VqT/QkdCGyQRvMRXTU
         GXbdtm9l+q2d1KKZh4FsG7C7U2n/XKwBILORllh27LnlPYfPATAEsss6vojHBDC8qHAe
         HSbqXlN0p0rEtqKBipaCCMefKHPB+dxDIqFDlitq0QYAhBh095Bsgsl4OwU2HmoHd03e
         JHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684499237; x=1687091237;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=Q8MH26l8qtMKGPwTVwmzMZucMaK/+tyytHAvVsFwBQIfainWZF3PctkOzLSaJTGelA
         OxF8BsmIq5/f5ubApPvJz4J9g0PXKrHRNQdMxpTCRSvPewlH3sfQDHCzbCjFcs+P9/Nw
         LQAd4FaH86hA6X+gP6QYKNVBhUg0ndXCIbDB6xg0Y3j8rG3msPyJHMw0WN46Z6evtJYA
         E7jxihF8xoMqAocNM+LNu+Wi45In/PSNC2WFsCPTtAtxepvd3n3N3yDGEolIfsTCMi7d
         1hbTXxNgHnSn4IpqnVdbx3yU2P9WHMcz6pK2KCeNaC1V/om1cGMuCy2Jk2SuqM+bwKPB
         Mdzw==
X-Gm-Message-State: AC+VfDzJY9eqiV4HrtySQ/QzpL0h2pdGDKgU12UFOGCCjZvuf3iq8JTy
        du+LKk/OppiwDjoZfIjh51WzZ7Xf8GVszdYQgGY=
X-Google-Smtp-Source: ACHHUZ5xnuIUgcxNG7ERe0k8ic5oToVmnttmz1deCvM416sX71V4OhSyAx9dKf49h60DjbBh+RdiBgrvxUGGp44/5Ts=
X-Received: by 2002:aa7:cd51:0:b0:50c:2215:317e with SMTP id
 v17-20020aa7cd51000000b0050c2215317emr1444690edw.15.1684499236712; Fri, 19
 May 2023 05:27:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:838e:b0:4e:ac54:3b57 with HTTP; Fri, 19 May 2023
 05:27:16 -0700 (PDT)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <wree3200@gmail.com>
Date:   Fri, 19 May 2023 05:27:16 -0700
Message-ID: <CA+C6PUNEWWxx_QT0J5JgDSQOCqGbM-wYXwYa=gCHmpzO8Pw9OQ@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:531 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [wree3200[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [wree3200[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
