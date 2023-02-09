Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A723B68FF7C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjBIEqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjBIEqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:46:10 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391476279E;
        Wed,  8 Feb 2023 20:44:02 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id o5so768395ljp.6;
        Wed, 08 Feb 2023 20:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=brNEnjw3/P/bcIbPP5bGSOdJWZu8MtNOmWrx7LzMZlk=;
        b=broYV6kas3IZzkIPpgTmGOgHLlQqZUjUnZSMcmWRs/MYblIwN7ZFvPDVHyO5nBi29H
         ovhscFZ8BDv2TzFYINHhl3DlBNG5+51COWJQnBhXPbWaKhQ+QFYANpJaHCze2tv3+0BZ
         3FNpZX6GBdZK/cS2oBlV/qIQNoLgvabmep3CDIixj6lBx9SJ3vQBp1Tf+EgE0sDV6hVg
         t7NFDQBndGKFCjpxk4x2R42daEnzZOB6b8cQFqRDT5RgLnJin14Ir64E77AncS3kiQvp
         QUGVr58uMlb/Af0OxSOGzUwKDNBE6mt7C3hlcnHGgcrHRS9bCEecR+r8SPTMQgoda22g
         Lfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=brNEnjw3/P/bcIbPP5bGSOdJWZu8MtNOmWrx7LzMZlk=;
        b=LWK1bofC75DTZ3L1Ht9ZUHG4Aa9N/JepIj644hRMMps/+lpUesUPw2kVEBtInBmQVb
         FAVNZbEYcfEJJhp+oKQxc9HFn9oX6W5yH7fjyZgOklN/zLLlWC6aHYXA3WjqStG8jCr7
         Tv4vo0fAGLdwbX+Tubn2Zin6hm7XrmFXpVmFkAmEMmOj55/OlrFbU8XQDGGls1OH69Wc
         Z+XMT3UbDcq8NUfrG9to8V4yHxh2uvPkjYcS0AOPeLjnW0j7GRZ2CmNcSSkLJmGgaiqw
         F+F8dyyvRmHHbSM2g2cTNTtUnkt3W3dEZuEMPxb0w6L4G+ZmKbiSJ4L4so7Ek7l+OAq+
         6D/A==
X-Gm-Message-State: AO0yUKVV55eWO7+2fTiPml8pZq1X/GyvT4xJNeyPnz+NZJAdtFQy6hca
        NgL3kF/o6Y4TYSLF7Ty5WVluKF/K3whv4RxcbNDvyOLJc60=
X-Google-Smtp-Source: AK7set+GphGpM7GDvLZYNt3eyh/hn500jEVP7DjrctTaQIF7BfwcGPQYdA1hM+JX7FrddG0vam1jrUF0mfxTeLvyGp8=
X-Received: by 2002:a2e:9c4b:0:b0:293:ed1:ee6f with SMTP id
 t11-20020a2e9c4b000000b002930ed1ee6fmr1861115ljj.119.1675917840128; Wed, 08
 Feb 2023 20:44:00 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 8 Feb 2023 22:43:48 -0600
Message-ID: <CAH2r5mut-6o5Jy7Kb8ZmjyRDikAi7iueqNStX1JLdixrFmJPZQ@mail.gmail.com>
Subject: [GIT PULL] smb3 client fix
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
aa5465aeca3c66fecdf7efcf554aed79b4c4b211:

  cifs: Fix use-after-free in rdata->read_into_pages() (2023-02-06
22:50:25 -0600)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.2-rc8-smb3-client-fix

for you to fetch changes up to aa5465aeca3c66fecdf7efcf554aed79b4c4b211:

  cifs: Fix use-after-free in rdata->read_into_pages() (2023-02-06
22:50:25 -0600)

----------------------------------------------------------------
small fix for use after free in readpages

----------------------------------------------------------------

-- 
Thanks,

Steve
