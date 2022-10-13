Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E1D5FD3FC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 06:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJME4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 00:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJME4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 00:56:22 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF93B10D68C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 21:56:20 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id h13so940107pfr.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 21:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=v0UkCHDCpb0SQXipAoNT2TBB6AI57CfyDRGKOFbFDxM=;
        b=02NaSQwYpacpxD453y5wlUVALaIMnCHleq/eMGjj6MbNnnksjxpiZPh7T/6ivwKs15
         B6M6NtF5b1z6oHsZkPKWM1Abynf19TqN6F/ymAq5N0DPqFF1DG1x27tOyEpNvae1DzMt
         OfNxH/H6uPut4s6x9gJ2Iy4tFZK25wLHvIC/9FjD8ErblkFCPHCHyQG5BhFVrGLQk1AP
         FElSsWsF3y55u22hLcDJAx8nFymW4+EtM8U21ENGEPDB/LCQSj66i0g00zgtocX7NcgV
         Wq2DDRzMIKLxM1ZW6KX2E9EH2dTb5/2eE13bXd39uP+3JvXQd0ik32n0HYiC4rlBtlEj
         Yu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0UkCHDCpb0SQXipAoNT2TBB6AI57CfyDRGKOFbFDxM=;
        b=OIwNezgrTXYxWwsDxaAg/VKowKuhRZT9nbPES8lGb+IrqBrxzg2Wt8lZGwF+T1bPDR
         0l7XthonjcVlrk9VwH5ixiuqSRfPaCjiQX26ePKfB54bV5aoTuJSW0YYE6zSbsXXx0Xi
         mE2F8p9DfW+TYQc0n9kYe++UKKtpYH83k3E3YoCWL/S282gIW75G7QV7C3Rv+dJDr3dm
         wOoP5JkIm8m8HBEl7VohNm0wTjSCtHjA4pjAnkEM1LmGfrWS76h7mgaOeoDDyvFmRGgt
         m2GoMXOnFraqgTXRC7CyrzDcUs1OqGek+PwY78LIBX1q/gWmeo2WWvb4xIFT/F7UZhkk
         YpQA==
X-Gm-Message-State: ACrzQf1pu2C9+7nL/Y4wJEso5aOx3nmqNC7nKhgxnScqh1hQz0AU+GOw
        9Ur//9yP0EYEbjm3d3id4s8phw==
X-Google-Smtp-Source: AMsMyM4xYxfSCrlo5ZD8i7krGTytpwPAaf5IcxrbU4QzjhRLQ4Wzrv7QyLp9p5ewMgSHjQwEongTBA==
X-Received: by 2002:a05:6a00:f03:b0:563:210a:5ffb with SMTP id cr3-20020a056a000f0300b00563210a5ffbmr24187318pfb.70.1665636980362;
        Wed, 12 Oct 2022 21:56:20 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id n3-20020a056a00212300b005625d6d2999sm750313pfj.187.2022.10.12.21.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 21:56:20 -0700 (PDT)
Subject: [PATCH v2 0/4] Documentation: RISC-V: patch-acceptance changes
Date:   Wed, 12 Oct 2022 21:56:15 -0700
Message-Id: <20221013045619.18906-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, Atish Patra <atishp@rivosinc.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@rivosinc.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>, Atish Patra <atishp@rivosinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We talked about this during Plumbers and it seems like there was pretty
minor feedback on the v1.  I don't intend on committing this for the
current merge window, as it's only been through one round of review and
I don't see any reason to rush it.  Like last time we're just violating
this as the status quo, so we can stick with that as we sort out the
wording.

Changes since v1 <https://lore.kernel.org/all/Yyn9FJ4iuzJTfO1T@spud/t/#mcc9b5e547a2ca2b25d7f78a4d2572f39ddc5593e>:
* Various minor wording changes.
* "UEFI forum specifications" instead of just "UEFI specifications".
* New patch 4 with implementor -> implementer
* Atish and Conor's Reviewed-by.


