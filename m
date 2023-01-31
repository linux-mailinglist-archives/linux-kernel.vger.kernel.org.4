Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60278683817
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 21:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjAaU5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 15:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjAaU45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 15:56:57 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7867A18AA7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 12:56:24 -0800 (PST)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CD8A744303
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 20:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675198566;
        bh=0j2ZICnG+w4G4N0kinwaAUyWnUe+Eo5pINxrbv2VLSM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=pFbx/7XLF1WWrdGW/JP4VyOPC8y7ABLFKiBeN7BiowGd/lW9CIiOreVMMWkjJMMUU
         mZnc85yND/HmLSWl3pT/Qw1pke6aTADpljfvC5F8N1ukry7B3LlDkByAdwnpAM5dxB
         qfiUDwk8FYd8qoFetw2krqQnGIsMAPU24Qb42TAow4/T4lH8RnyzKUPoAHZnl+2amr
         dxmX+bw/jBOOyOpPun5pEGGKC+0He6fOeUIVPzFHJhzQpwC4I411tB3QnXGAjSY8Os
         D3YGhDea61puo79mfOVius/HMBD0ks+0IdcNFAeQuzZ3Ieh8rZD7rU6UeTJ/QbPVrX
         Pq3MR45PecPaw==
Received: by mail-wm1-f69.google.com with SMTP id m10-20020a05600c3b0a00b003dafe7451deso9409222wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 12:56:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0j2ZICnG+w4G4N0kinwaAUyWnUe+Eo5pINxrbv2VLSM=;
        b=RuePngAZAGOsi9E8lzX/Adm5Ew85Rg0wz9NT2M0EZzTvyVjtsFU9PMFxuTSOLXS8UB
         qvqfzNkY20PIAxBsPfCe/mZuUdQqwarsEYulzrwpNvyd4a9AbC/C1MVaqExoVmwx9XLW
         eZ/BnWAtxZrOKifFSsSEfXF71v8zClHE7gTKuQkBmIo3Iijk1y3WGtWktcHzjKxVbYWk
         HD/UGISbsztb4y/h+I1a69d2y4bZaqpYeyNeSIsTGDZXDVaFtb3kr2v3lLuk/fmKHCpE
         Ojw/+lzgOmJaBHOuErR2aehf9Y2QI40/j6rZrx1D5IBe6Zl3wzHtva4OoXZsKPdkrX9/
         9xFw==
X-Gm-Message-State: AFqh2kovJdrVKEdkyMmOYQi4LmjmGeI/OnzKurPOZwpIKRLWlNj6KN6x
        ZSfd+r4NmNMEuUa8743kkDYdWO34oX+TTH9Hw2W1OXQkt/lDsEQumc7VcyY4PINOpwuR5mhiMAf
        mP/412WX5Ka1ZnAru3+HHZjdMfWvedXTmsEwBKNpxSw==
X-Received: by 2002:a05:600c:3d16:b0:3db:1ae8:ad98 with SMTP id bh22-20020a05600c3d1600b003db1ae8ad98mr48532212wmb.33.1675198565937;
        Tue, 31 Jan 2023 12:56:05 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvqDSHUeQD5Tnq9NnB4o+TBhnH6jqOD81n/j3Ubc2K7QwjKWheB/YHLYZttxP1P2b+R9LSkBg==
X-Received: by 2002:a05:600c:3d16:b0:3db:1ae8:ad98 with SMTP id bh22-20020a05600c3d1600b003db1ae8ad98mr48532198wmb.33.1675198565777;
        Tue, 31 Jan 2023 12:56:05 -0800 (PST)
Received: from qwirkle.internal ([81.2.157.149])
        by smtp.gmail.com with ESMTPSA id bd16-20020a05600c1f1000b003d1f3e9df3csm21316535wmb.7.2023.01.31.12.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 12:56:05 -0800 (PST)
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Willem de Bruijn <willemb@google.com>
Cc:     Andrei Gherzan <andrei.gherzan@canonical.com>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/4] selftests: net: udpgso_bench_rx/tx: Stop when wrong CLI args are provided
Date:   Tue, 31 Jan 2023 20:53:18 +0000
Message-Id: <20230131205318.475414-2-andrei.gherzan@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131205318.475414-1-andrei.gherzan@canonical.com>
References: <20230131205318.475414-1-andrei.gherzan@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leaving unrecognized arguments buried in the output, can easily hide a
CLI/script typo. Avoid this by exiting when wrong arguments are provided to
the udpgso_bench test programs.

Fixes: 3a687bef148d ("selftests: udp gso benchmark")
Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
CC: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/net/udpgso_bench_rx.c | 2 ++
 tools/testing/selftests/net/udpgso_bench_tx.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/udpgso_bench_rx.c b/tools/testing/selftests/net/udpgso_bench_rx.c
index d0895bd1933f..4058c7451e70 100644
--- a/tools/testing/selftests/net/udpgso_bench_rx.c
+++ b/tools/testing/selftests/net/udpgso_bench_rx.c
@@ -336,6 +336,8 @@ static void parse_opts(int argc, char **argv)
 			cfg_verify = true;
 			cfg_read_all = true;
 			break;
+		default:
+			exit(1);
 		}
 	}
 
diff --git a/tools/testing/selftests/net/udpgso_bench_tx.c b/tools/testing/selftests/net/udpgso_bench_tx.c
index f1fdaa270291..b47b5c32039f 100644
--- a/tools/testing/selftests/net/udpgso_bench_tx.c
+++ b/tools/testing/selftests/net/udpgso_bench_tx.c
@@ -490,6 +490,8 @@ static void parse_opts(int argc, char **argv)
 		case 'z':
 			cfg_zerocopy = true;
 			break;
+		default:
+			exit(1);
 		}
 	}
 
-- 
2.34.1

