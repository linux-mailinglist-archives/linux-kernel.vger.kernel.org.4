Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A2674E413
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 04:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjGKCaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 22:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjGKCaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 22:30:19 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096A7197
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 19:30:18 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a640c23a62f3a-993d1f899d7so494488966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 19:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689042616; x=1691634616;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D5t86Vhqf7sH2E/bqaCAwQHLnRJQ5XfE0wzJqvYeJ7Y=;
        b=eJ4q6sZaTla2s93SXFOz541zJjSgNHtawdRntQz3YrVAoT601MyEiNpfmXI/GCk6Am
         UnAv7xX3XeM/CayVdzipo+qzdSQVDURxFEQ/+xh9ddnFvnGFNG/aGTs3q6r0J/RoZUSS
         jdcT6HRG6hUBNBDCQSRux3sBOvpCXvqnFl7YvPenWy1ynRzhjRMjHrye2t7TrbYSYvgU
         TSk011ZGnLb0hmxNtjxVf8O2ANFBgK2woj/MCOYd8SfYM2oT7k10+jbJdq8z6G8QgcUF
         6L35xBmWW+gOyyiRlZhqY5gXiIf0S4joJbeqW5YgJJV99khKJcsOgkrH+NgvpCcy0S15
         OAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689042616; x=1691634616;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5t86Vhqf7sH2E/bqaCAwQHLnRJQ5XfE0wzJqvYeJ7Y=;
        b=XY5CMUzIBjPoDoEmsgvcVFTpQef7jbkvBl673A/a9ZyivF46V3KZrhoUcqaiCnWxXs
         4Hly7rNfdK1ZywULLDzwB88ASkkro5foE2BZg/qnQoTDIa8B5NRd043yBy2rRz78zxsr
         s0c2bJOQLAG/eefzhvzV7YrhzzKnNVHDQSbgBeRwcqXz242T4H9F2c9RlJLkzBmwpKiF
         2UEAdkigLxqhDUye5DCYL87W4CSX0gI/2Ivi46Eaznfz4FZ/fSaLTR8sBIwHiOdP5+C8
         huhUiXz2+bl9V8/0CudfNxaTNGniaHTxGAPfkX5ABp7uhxEu4LNQQWbj7XNs+lPSzhnp
         ZdaA==
X-Gm-Message-State: ABy/qLa2f/5gWDOFm8zPpoaYxSLKs0dqCEOwdK8SFYITayMN3UMDvWY6
        M0FFTn/RF6o+MBxjIt8RfADM+sUn2FUfDxjs
X-Google-Smtp-Source: APBJJlFeLdTvSGTQ5klQSQV3c6zUL7aRY8pqqlo+W7a2VDFH1mT1fPR2Zc8dcSkNfsoTJfchO2VXGg==
X-Received: by 2002:a17:907:9008:b0:988:9621:d85f with SMTP id ay8-20020a170907900800b009889621d85fmr12738558ejc.58.1689042616167;
        Mon, 10 Jul 2023 19:30:16 -0700 (PDT)
Received: from DESKTOP-0292RPC ([41.191.41.237])
        by smtp.gmail.com with ESMTPSA id gx17-20020a170906f1d100b00992aea2c55dsm461635ejb.153.2023.07.10.19.30.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 10 Jul 2023 19:30:15 -0700 (PDT)
Message-ID: <64acbeb7.170a0220.e94ab.1cf0@mx.google.com>
Date:   Mon, 10 Jul 2023 19:30:15 -0700 (PDT)
X-Google-Original-Date: 11 Jul 2023 10:30:14 +0800
MIME-Version: 1.0
From:   "Ugent" <pinterpol33324@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: Interpol Police Summons
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R29vZCBldmVuaW5nCgpGb2xsb3dpbmcgYSBjb21wbGFpbnQgZmlsZWQgYnkgdGhlIG1p
Y3Jvc29mdCBhZ2VuY3kuCgpmZXcgbW9udGhzIG9uIHNjcmVlbiB3ZSB0cmFja2VkIGFs
bCBvZiB5b3VyIGJyb3dzaW5nLCBtZXNzYWdlIGFuZCByZWNlbnQgYWN0aXZpdHkgdGhh
dCB5b3UgdXNlZCB2aWEgaW50ZXJuZXQgYWxzbyB0aGUgc2xpbmdzIHRoYXQgeW91IGNv
bW1pdHRlZCBhZ2FpbnN0IHRoZSB3ZWIsIHBob3RvcyBhbmQgdmlkZW9zIG9mIHlvdSBp
biBiYWQgcG9yc3R1ZS4KCiAgV2UgaW5mb3JtIHlvdSB0aGF0IHNoYXJpbmcsIHNlbmRp
bmcgcGhvdG9zIGFuZCB2aWRlb3Mgb2YgYSBzZXh1YWwgbmF0dXJlIGFyZSBzdHJpY3Rs
eSBwcm9oaWJpdGVkLgoKYSBzdW1tb25zIHdpbGwgYmUgZGVwb3NpdGVkIGF0IHlvdXIg
YWRkcmVzcyBpbiB0aGUgbmV4dCBmZXcgZGF5cyB3aXRoIHdoaWNoIHlvdSB3aWxsIGdv
IHRvIHRoZSBwb2xpY2Ugc3RhdGlvbiB0byBhcHBlYXIgYmVmb3JlIHRoZSBsYXcuCgp5
b3UgaGF2ZSBsZXNzIHRoYW4gMjQgaG91cnMgdG8gbGVhdmUgYSByZXNwb25zZSBpbiBj
YXNlIHRoZSBwb2xpY2Ugb2ZmaWNlcnMgZG8gbm90IGNvbWUgdG8geW91ciBob3VzZS4K
CnBsZWFzZSBjb250YWN0IHRoaXMgRV9tYWlsIGFkZHJlc3MgZm9yIHRoZSByZXN0OiBl
dHVkZW5vdGFyaWE3NUBnbWFpbC5jb20uCgpZb3UgaGF2ZSB0aGUgY2hvaWNlIG9mIGNv
bnRhY3RpbmcgYSBsYXd5ZXIuCgogICAgICAgICBGZWRlcmFsIEJ1cmVhdS1JbnZlc3Rp
Z2F0aW9uCiAgICAgICAgICBBZHJlc3NlIDogQWRyZXNzZSA6IDU1NSAxMXRoIFN0IE5X
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICBXYXNoaW5ndG9uLCBEQyAyMDAwNCwg
w4l0YXRzLVVuaXMKICAgICAgICAgIFTDqWzDqXBob25lIDogKzEgMjAyLTMyNC0zMDAw

