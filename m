Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F796632BE4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 19:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiKUSRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 13:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiKUSRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 13:17:04 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA87FC696E;
        Mon, 21 Nov 2022 10:16:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6EV4+W+06zBusetXdfuTOjtNP3IMkhCODszudptN/cTk9NAuyjjpgUAihHMlPEzOTN2BCXC0SElvOUqFmAWLQ+xwTzYEF22M1hGS9gNwb88tglZTQDfaYDXeH8sgce/4cfmnl9coPVYm8rDrHd1ZXCFpJ4KcNznQDv31DQNlWbx6ZBDB1skl7U+WtC8a2TKK0cnEPOyeRc5KaBpAg1MhiQ6coZBNl0tliIk1YXdbhNpoaSihBHDnfmHd4lO2rbFEg8/966Hbx7wpx59LhAQe7/XLGVV13Vu0T5z86UGQ9QB3/FgsJ7Lpqn08wbGY0gH5cp3aPFEZCX7024xC6peAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njvewn3A9wRcwR7r3PvMWT2retvWNJt0j4hJ0OuOJWY=;
 b=mJDOJp2Q8UaPwZf2BOIt2FBKfNpd3tqhPI4S3C9rD8lTGF8FiIBdAKOoHH10bb+fKyUQdPu4zH+3OXAfvgQ4l+CbilyG/lwcAD1iJx0p4GJfUPWGMPa2x/eyRCiDZcHCZxlOo6ZXfXZDVe2nqJvqLMrjIIkszP+Jp7aApiriiQADSwMbJ6/rOYo9s4ZrWjTKMFVdRmiaLA7vEz8gdopUn3V4+WPmdkef2Azkk6gBz4k7i9j/hdU5YpC8kwtiupNG+DIN41FKhkPrx0vrRhzaVvTRT9PH3z0HuoNQjerwRs/KYUKFynNfw6HMRbQeFv07SrlO0XcAq/045RfYrzqSug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njvewn3A9wRcwR7r3PvMWT2retvWNJt0j4hJ0OuOJWY=;
 b=W588W1F/g3QP7aFJr7XjaYSKrFxTJlp47QMV5jW2rHgnkMAJC+IAOqhnJ80r5EFpORYfHYQOldlGDFCREQtgvYYipUOETb1FjF3lLDXIuLAoUfc39eTkqiKFDGRNJLDO0ev3QDCv0UBgAsaeAHE1HniHMsvYto6caYHhofDiwqE=
Received: from DS7PR06CA0030.namprd06.prod.outlook.com (2603:10b6:8:54::22) by
 DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Mon, 21 Nov 2022 18:16:56 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::87) by DS7PR06CA0030.outlook.office365.com
 (2603:10b6:8:54::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Mon, 21 Nov 2022 18:16:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Mon, 21 Nov 2022 18:16:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 12:16:54 -0600
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 21 Nov 2022 12:16:33 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>, <lukas.bulwahn@gmail.com>, <ojeda@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <bilbao@vt.edu>, <jm@goyeneche.es>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH v2 2/2] docs/sp_SP: Add process kernel-docs translation
Date:   Mon, 21 Nov 2022 12:16:26 -0600
Message-ID: <20221121181626.149558-3-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221121181626.149558-1-carlos.bilbao@amd.com>
References: <20221121181626.149558-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT013:EE_|DS0PR12MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: f231c00d-95d9-4e86-059b-08dacbec9324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3sbMSn6f1h0i74yal46lOgJiVKLTcorJ4oS4aKz+RBNHVzncsOMzfjRV2rZeixDdcoKEd62nIE9IepU1mPHV2dnxTDgTCA3T5UaPyCXuFs2JcXn+FN7LEHjb0iNqErk2NIEVUa/vaEtn2zLfjyoPDlykVNvouteKrZW5piQke+7B2nTNhHf6s8FvMV+MPjXWBqejGkcMpQCqHdOILC+0Fl0P62eNZn8hUnkyYp0RyEi+S7714qdkqKB8ngrdpBfHTEO5XneTIHaLnZ+5N1PZ6fv8X6JkAaWfWeNhEtPry36tMM6/INbuxExYAkpm1yAXVy6CWrr8ffgHXV9s5a1wsKJkMnrMbbPTUa3wFTRCBLbrDVeUz/jZiCriHtwuzgw3SWCQ6543zXthR9Jt4sKViswX0hKTEDoGeRUxa6YlVeDhzcKQmrVXy+p8Ld1bl289ydJkOmxNDcjTe9ucq475h0SNTVKPRba8bL+kncC4I6yHzlxCCoP9Uhl0bUG6UP2GKoZKW9Jmj0azjJl5k8wnI/0dt2+WOUz0v2nORSP1CjkrWfi12DS5FIBfD9dqtuOmdg4uJH5Mu+LSB53l0zX8ngPoQoW60mbWRiHkZ8QwB9IrFEbbkc0koL+m+42+P/Ck5uUTWNAsO2KZyFFgsLGdpfLI02QddetS3a8cJcJX/wmOhxjm8LaZpBY1HrH2MB1tTpdxSdtPdDPdzBjJ48KM/U6/LrjfpE0vkCBlZpe6MrvlnBUSxVUtFGjF+2xF3FqB1AAIx3VXWLYsRDbBZI9GkR8emVOcVClSnYB98WogX+OBaHwf2VNyEzy7JlANSADWNhL/XnozOJ9IAKc8fqQqREEhX2CbpPFfSTQuH0JAkVk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:es;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(36840700001)(46966006)(40470700004)(6666004)(478600001)(66899015)(966005)(70586007)(36756003)(110136005)(41300700001)(8676002)(16799955002)(4326008)(30864003)(70206006)(186003)(2616005)(8936002)(1076003)(26005)(40460700003)(44832011)(5660300002)(336012)(316002)(54906003)(7696005)(83380400001)(82740400003)(2906002)(86362001)(47076005)(66574015)(40480700001)(426003)(15188155005)(36860700001)(82310400005)(81166007)(356005)(562404015)(36900700001)(19623215001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 18:16:56.6897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f231c00d-95d9-4e86-059b-08dacbec9324
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate Documentation/process/kernel-docs.rst into Spanish.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 Documentation/translations/sp_SP/index.rst    |   2 +-
 .../translations/sp_SP/kernel-docs.rst        | 641 ++++++++++++++++++
 2 files changed, 642 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/sp_SP/kernel-docs.rst

diff --git a/Documentation/translations/sp_SP/index.rst b/Documentation/translations/sp_SP/index.rst
index 519c5ef9ac9d..c60c6947d2b4 100644
--- a/Documentation/translations/sp_SP/index.rst
+++ b/Documentation/translations/sp_SP/index.rst
@@ -80,7 +80,7 @@ Traducciones al español
    howto
    submitting-patches
    coding-style
+   kernel-docs
 
 .. include:: ./memory-barriers.txt
     :literal:
-
diff --git a/Documentation/translations/sp_SP/kernel-docs.rst b/Documentation/translations/sp_SP/kernel-docs.rst
new file mode 100644
index 000000000000..161402a86a79
--- /dev/null
+++ b/Documentation/translations/sp_SP/kernel-docs.rst
@@ -0,0 +1,641 @@
+.. include:: ./disclaimer-sp.rst
+
+:Original: :ref:`Documentation/process/kernel-docs.rst <kernel_docs>`
+:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+
+.. _sp_kernel_docs:
+
+Índice de documentación adicional del kernel
+============================================
+
+La necesidad de un documento como este se hizo evidente en la lista de
+correo de linux-kernel cuando las mismas preguntas, solicitando sugerencias
+e información, aparecieron una y otra vez.
+
+Afortunadamente, a medida que más y más gente accede a GNU/Linux, más
+desarrolladores se interesan por el kernel. Sin embargo, leer las fuentes
+no siempre es suficiente. Es fácil entender el código, pero se pierden los
+conceptos, la filosofía y decisiones de diseño detrás de dicho código.
+
+Desafortunadamente, no existen muchos documentos disponibles para que los
+principiantes comiencen. Y, aunque existieran, no habría ningún lugar
+"conocido" que les pudiera seguir la pista. Estas líneas tratan de cubrir
+esta carencia.
+
+POR FAVOR, si conoce algún documento que no figura aquí, o si escribe un
+nuevo documento, incluya una referencia aquí, siguiendo el proceso de envío
+de parches del kernel. Cualquier corrección, idea o comentario también es
+bienvenida.
+
+Todos los documentos se catalogan con los siguientes campos: el "Título",
+el "Autor"/es, la "URL" donde se encuentran, algunas "Palabras clave"
+útiles para buscar temas específicos, y una breve "Descripción" del
+documento en cuestión.
+
+.. note::
+
+   Los documentos de cada sección en este documento están ordenados por su
+   fecha de publicación, del más reciente al más antiguo.
+
+Documentos en el árbol del kernel Linux
+-----------------------------------------
+
+Los libros de Sphinx deben compilarse con ``make {htmldocs | pdfdocs | epubdocs}``.
+
+    * Título: **linux/Documentation**
+
+      :Autor: Many.
+      :Ubicación: Documentation/
+      :Palabras Clave: archivos de texto, Sphinx.
+      :Descripción: Documentación que viene con las fuentes del kernel,
+        dentro del directorio Documentation. Algunas páginas de este documento
+        (incluido este documento en sí) se han trasladado allí, y podrían
+        estar más actualizadas que la versión web.
+
+Documentos en línea
+-------------------
+
+    * Título: **Linux Kernel Mailing List Glossary**
+
+      :Autor: various
+      :URL: https://kernelnewbies.org/KernelGlossary
+      :Fecha: rolling version
+      :Palabras Clave: glosario terminos, linux-kernel.
+      :Descripción: De la Introducción: "This glossary is intended as
+        a brief description of some of the acronyms and terms you may hear
+        during discussion of the Linux kernel".
+
+    * Título: **Tracing the Way of Data in a TCP Connection through the Linux Kernel**
+
+      :Autor: Richard Sailer
+      :URL: https://archive.org/details/linux_kernel_data_flow_short_paper
+      :Fecha: 2016
+      :Palabras Clave: Linux Kernel Networking, TCP, tracing, ftrace
+      :Descripción: A seminar paper explaining ftrace and how to use it for
+        understanding linux kernel internals,
+        illustrated at tracing the way of a TCP packet through the kernel.
+      :Resumen: *Este breve documento describe el uso del framework de
+        tracing ftrace como una herramienta para comprender un sistema
+        Linux en ejecución. Habiendo obtenido un "trace-log", un hacker del
+        kernel puede leer y comprender código fuente con más determinación
+        y contexto. En un ejemplo detallado, este enfoque se demuestra al
+        rastrear datos en una conexión TCP a través del kernel. Finalmente,
+        tal registro se utiliza como base para una más exacta exploración
+        y descripción conceptual de la implementación de Linux TCP/IP.*
+
+    * Título: **The Linux Kernel Module Programming Guide**
+
+      :Autor: Peter Jay Salzman, Michael Burian, Ori Pomerantz, Bob Mottram,
+        Jim Huang.
+      :URL: https://sysprog21.github.io/lkmpg/
+      :Fecha: 2021
+      :Palabras Clave: modules, GPL book, /proc, ioctls, system calls,
+        interrupt handlers .
+      :Descripción: Un muy buen libro GPL sobre el tema de la programación
+        de módulos. Muchos ejemplos. Actualmente la nueva versión está
+        siendo mantenida activamente ent https://github.com/sysprog21/lkmpg.
+
+    * Título: **On submitting kernel Patches**
+
+      :Autor: Andi Kleen
+      :URL: http://halobates.de/on-submitting-kernel-patches.pdf
+      :Fecha: 2008
+      :Palabras Clave: patches, review process, types of submissions, basic rules, case studies
+      :Descripción: Este documento brinda valiosa experiencia sobre qué
+        tipos de parches hay y la probabilidad de que se acepten.
+      :Resumen:
+        [...]. En este artículo se examinan algunos problemas comunes para
+         presentar cambios más grandes y algunas estrategias para evitar
+         problemas.
+
+    * Título: **Linux Device Drivers, Third Edition**
+
+      :Autor: Jonathan Corbet, Alessandro Rubini, Greg Kroah-Hartman
+      :URL: https://lwn.net/Kernel/LDD3/
+      :Fecha: 2005
+      :Descripción: Un libro de 600 páginas que cubre la API (2.6.10)
+         programación de drivers y temas hacker del kernel en general.
+         Disponible bajo licencia Creative Commons Attribution-ShareAlike 2.0.
+      :note: También puede :ref:`comprar una copia en O'Reilly o en otro lugar <sp_ldd3_published>`.
+
+    * Título: **Writing an ALSA Driver**
+
+      :Autor: Takashi Iwai <tiwai@suse.de>
+      :URL: https://www.kernel.org/doc/html/latest/sound/kernel-api/writing-an-alsa-driver.html
+      :Fecha: 2005
+      :Palabras Clave: ALSA, sonido, tarjeta de sonido, driver, bajo nivel, hardware.
+      :Descripción: Advanced Linux Sound Architecture para desarrolladores,
+         tanto en el kernel como a nivel de usuario. ALSA era la aquitectura
+         de sonido del kernel de Linux en la versión kernel 2.6.
+
+    * Título: **Linux PCMCIA Programmer's Guide**
+
+      :Autor: David Hinds.
+      :URL: http://pcmcia-cs.sourceforge.net/ftp/doc/PCMCIA-PROG.html
+      :Fecha: 2003
+      :Palabras Clave: PCMCIA.
+      :Descripción: "Este documento describe cómo escribir drivers kernel
+         para la interfaz Card Services de la tarjeta PCMCIA de Linux.
+         También describe cómo escribir utilidades en modo usuario para
+         comunicarse con Card Services.
+
+    * Título: **How NOT to write kernel drivers**
+
+      :Autor: Arjan van de Ven.
+      :URL: https://landley.net/kdocs/ols/2002/ols2002-pages-545-555.pdf
+      :Fecha: 2002
+      :Palabras Clave: driver.
+      :Descripción: Programming bugs and Do-nots in kernel driver development
+      :Resumen: *Quitando algunos tutoriales, artículos y libros que hacen
+         una introducción sobre cómo escribir drivers del kernel de Linux,
+         desafortunadamente, las cosas que NO se deben hacer en código del
+         kernel de Linux son solo un apéndice menor o, más comúnmente,
+         están completamente ausentes. Este trabajo intenta tocar
+         brevemente las áreas en que se encuentran los errores e
+         inconvenientes más comunes y graves.*
+
+    * Título: **Global spinlock list and usage**
+
+      :Autor: Rick Lindsley.
+      :URL: http://lse.sourceforge.net/lockhier/global-spin-lock
+      :Fecha: 2001
+      :Palabras Clave: spinlock.
+      :Descripción: Este es un intento de documentar tanto la existencia
+         como el uso de spinlocks en el kernel de Linux 2.4.5. Lista
+         exhaustiva de spinlocks que muestra cuándo se usan, qué funciones
+         acceden a ellos, cómo se adquiere cada bloqueo, en qué condiciones
+         se poseen, si pueden ocurrir interrupciones o no mientras se
+         poseen...
+
+    * Título: **A Linux vm README**
+
+      :Autor: Kanoj Sarcar.
+      :URL: http://kos.enix.org/pub/linux-vmm.html
+      :Fecha: 2001
+      :Palabras Clave: memoria virtual, mm, pgd, vma, flags de pagina, pagina,
+        cache, swap cache, kswapd.
+      :Descripción: Breves descripciones y definiciones relacionandas con
+         la implementación de memoria virtual en Linux.
+
+    * Título: **Video4linux Drivers, Part 1: Video-Capture Device**
+
+      :Autor: Alan Cox.
+      :URL: http://www.linux-mag.com/id/406
+      :Fecha: 2000
+      :Palabras Clave: video4linux, driver, captura de video, dispositivos
+        de captura, driver de camara, video.
+      :Descripción: El título (dispositivo de captura de video) lo dice todo.
+
+    * Título: **Video4linux Drivers, Part 2: Video-capture Devices**
+
+      :Autor: Alan Cox.
+      :URL: http://www.linux-mag.com/id/429
+      :Fecha: 2000
+      :Palabras Clave: video4linux, driver, captura de video, capture devices,
+        driver de camara, control, query capabilities, capability, facility.
+      :Descripción: El título (dispositivo de captura de video) lo dice todo.
+
+    * Título: **Linux IP Networking. A Guide to the Implementation and Modification of the Linux Protocol Stack.**
+
+      :Autor: Glenn Herrin.
+      :URL: http://www.cs.unh.edu/cnrg/gherrin
+      :Fecha: 2000
+      :Palabras Clave: red, redes, protocol, IP, UDP, TCP, conexión,
+        socket, receiving, transmitting, forwarding, routing, paquetes,
+        módulos, /proc, sk_buff, FIB, tags, transmitir.
+      :Descripción: Excelente artículo dedicado a las redes IP de Linux,
+         explicando cualquier cosa, desde el kernel hasta el código de las
+         herramientas de configuración de espacio de usuario. Muy bueno
+         para obtener una visión general de la implementación de red del
+         kernel y entender todos los pasos que los paquetes siguen desde el
+         momento en que se reciben en el dispositivo de red hasta que se
+         envían a las aplicaciones. El kernel estudiado es de la versión
+         2.2.14. Proporciona código para un ejemplo de "packet dropper".
+
+    * Título: **How To Make Sure Your Driver Will Work On The Power Macintosh**
+
+      :Autor: Paul Mackerras.
+      :URL: http://www.linux-mag.com/id/261
+      :Fecha: 1999
+      :Palabras Clave: Mac, Power Macintosh, porting, drivers, compatibility.
+      :Descripción: El título lo dice todo (driver en Mac).
+
+    * Título: **An Introduction to SCSI Drivers**
+
+      :Autor: Alan Cox.
+      :URL: http://www.linux-mag.com/id/284
+      :Fecha: 1999
+      :Palabras Clave: SCSI, device, driver.
+      :Descripción: El título lo dice todo (drivers SCSI).
+
+    * Título: **Advanced SCSI Drivers And Other Tales**
+
+      :Autor: Alan Cox.
+      :URL: http://www.linux-mag.com/id/307
+      :Fecha: 1999
+      :Palabras Clave: SCSI, device, driver, advanced.
+      :Descripción: El título lo dice todo (drivers SCSI avanzados).
+
+    * Título: **Writing Linux Mouse Drivers**
+
+      :Autor: Alan Cox.
+      :URL: http://www.linux-mag.com/id/330
+      :Fecha: 1999
+      :Palabras Clave: ratón, driver, gpm.
+      :Descripción: El título lo dice todo (drivers para el ratón en Linux).
+
+    * Título: **More on Mouse Drivers**
+
+      :Autor: Alan Cox.
+      :URL: http://www.linux-mag.com/id/356
+      :Fecha: 1999
+      :Palabras Clave: ratón, driver, gpm, races, asynchronous I/O.
+      :Descripción: El título todavía lo dice todo (mas sobre drivers para
+         el ratón en Linux)..
+
+    * Título: **Writing Video4linux Radio Driver**
+
+      :Autor: Alan Cox.
+      :URL: http://www.linux-mag.com/id/381
+      :Fecha: 1999
+      :Palabras Clave: video4linux, driver, radio, radio devices, dispositivos de radio.
+      :Descripción: El título lo dice todo (driver para radio Video4linux).
+
+    * Título: **I/O Event Handling Under Linux**
+
+      :Autor: Richard Gooch.
+      :URL: https://web.mit.edu/~yandros/doc/io-events.html
+      :Fecha: 1999
+      :Palabras Clave: IO, I/O, select(2), poll(2), FDs, aio_read(2), readiness
+        event queues, colas de eventos.
+      :Descripción: De la Introducción: "I/O Event handling is about
+        how your Operating System allows you to manage a large number of
+        open files (file descriptors in UNIX/POSIX, or FDs) in your
+        application. You want the OS to notify you when FDs become active
+        (have data ready to be read or are ready for writing). Ideally you
+        want a mechanism that is scalable. This means a large number of
+        inactive FDs cost very little in memory and CPU time to manage".
+
+    * Título: **(nearly) Complete Linux Loadable Kernel Modules. The definitive guide for hackers, virus coders and system administrators.**
+
+      :Autor: pragmatic/THC.
+      :URL: http://packetstormsecurity.org/docs/hack/LKM_HACKING.html
+      :Fecha: 1999
+      :Palabras Clave: syscalls, interceptar, ocultar, abusar, symbol table.
+      :Descripción: Interesante artículo sobre cómo abusar del kernel Linux
+         para interceptar y modificar syscalls, hacer archivos/directorios/procesos
+         invisibles, convertirse en root, secuestrar ttys, escribir virus
+         basados en módulos del kernel... y soluciones para que los
+         administradores eviten todos esos abusos.
+      :Notas: Para kernels 2.0.x. Da instrucciones para portarlo a kernels
+        2.2.x.
+
+    * Título: **Linux Virtual File System**
+
+      :Autor: Peter J. Braam.
+      :URL: http://www.coda.cs.cmu.edu/doc/talks/linuxvfs/
+      :Fecha: 1998
+      :Palabras Clave: slides, VFS, inodo, superblock, dentry, dcache.
+      :Descripción: Conjunto de diapositivas, presumiblemente de una
+         presentación del layer Linux VFS. Cubre la versión 2.1.x, con
+         dentries y el dcaché.
+
+    * Título: **The Venus kernel interface**
+
+      :Autor: Peter J. Braam.
+      :URL: http://www.coda.cs.cmu.edu/doc/html/kernel-venus-protocol.html
+      :Fecha: 1998
+      :Palabras Clave: coda, filesystem, venus, cache manager, sistemas de ficheros.
+      :Descripción: "This document describes the communication between
+        Venus and kernel level file system code needed for the operation
+        of the Coda filesystem. This version document is meant to describe
+        the current interface (version 1.0) as well as improvements we
+        envisage".
+
+    * Título: **Design and Implementation of the Second Extended Filesystem**
+
+      :Autor: Rémy Card, Theodore Ts'o, Stephen Tweedie.
+      :URL: https://web.mit.edu/tytso/www/linux/ext2intro.html
+      :Fecha: 1998
+      :Palabras Clave: ext2, historia de linux fs, inode, directory, link, devices,
+        VFS, physical structure, performance, benchmarks, ext2fs library,
+        ext2fs tools, e2fsck, inodo, rendimiento, libreria, dispositivos.
+      :Descripción: Documento escrito por tres de los mejores hackers de ext2.
+        Cubre la historia de los sistemas de archivos de Linux, la
+        motivación de ext2, las características de ext2, diseño, estructura
+        física en disco, rendimiento, benchmarks, descripción de los pases
+        de e2fsck... De lectura obligada!
+      :Notas: Este artículo se publicó por primera vez el Proceedings of the
+        First Dutch International Symposium on Linux, ISBN 90-367-0385-9.
+
+    * Título: **The Linux RAID-1, 4, 5 Code**
+
+      :Autor: Ingo Molnar, Gadi Oxman and Miguel de Icaza.
+      :URL: http://www.linuxjournal.com/article.php?sid=2391
+      :Fecha: 1997
+      :Palabras Clave: RAID, MD driver.
+      :Descripción: artículo del Linux Journal Kernel Korner.
+      :Resumen: *Una descripción de la implementación de RAID-1,
+        personalidades RAID-4 y RAID-5 del driver de dispositivo MD en el
+        kernel Linux, proporcionando a los usuarios una capacidad de
+        almacenamiento secundaria de alto rendimiento y fiabilidad, usando
+        software*.
+
+    * Título: **Linux Kernel Hackers' Guide**
+
+      :Autor: Michael K. Johnson.
+      :URL: https://www.tldp.org/LDP/khg/HyperNews/get/khg.html
+      :Fecha: 1997
+      :Palabras Clave: device drivers, files, VFS, kernel interface, character vs
+        block devices, hardware interrupts, scsi, DMA, access to user memory,
+        memory allocation, timers, archivos, interfaz del kernel, interrupciones.
+      :Descripción: Una guía diseñada para ayudarle a ponerse al día sobre
+        los conceptos que no son intuitivamente obvios, y para documentar
+        la estructuras interna de Linux.
+
+    * Título: **Dynamic Kernels: Modularized Device Drivers**
+
+      :Autor: Alessandro Rubini.
+      :URL: http://www.linuxjournal.com/article.php?sid=1219
+      :Fecha: 1996
+      :Palabras Clave: device driver, module, loading/unloading modules,
+        allocating resources, modulos, asignando recursos, módulos kernel cargables.
+      :Descripción: artículo del Linux Journal Kernel Korner.
+      :Resumen: *Este es el primero de una serie de cuatro artículos
+        co-escrito por Alessandro Rubini y Georg Zezchwitz que presentan
+        un enfoque práctico para escribir drivers de dispositivos Linux
+        como módulos kernel cargables. Esta entrega presenta una
+        introducción al tema, preparando al lector para entender la entrega
+        del próximo mes*.
+
+    * Título: **Dynamic Kernels: Discovery**
+
+      :Autor: Alessandro Rubini.
+      :URL: http://www.linuxjournal.com/article.php?sid=1220
+      :Fecha: 1996
+      :Palabras Clave: character driver, init_module, clean_up module,
+        autodetection, mayor number, minor number, file operations,
+        open(), close(), dispositivo, driver de caracteres.
+      :Descripción: artículo del Linux Journal Kernel Korner.
+      :Resumen: *Este artículo, el segundo de cuatro, introduce parte de
+         código real para crear un módulo personalizado que implemente un
+         driver de dispositivo. Describe el código para la inicialización
+         del módulo y limpieza, así como las llamadas al sistema open() y
+         close()*.
+
+    * Título: **The Devil's in the Details**
+
+      :Autor: Georg v. Zezschwitz and Alessandro Rubini.
+      :URL: http://www.linuxjournal.com/article.php?sid=1221
+      :Fecha: 1996
+      :Palabras Clave: read(), write(), select(), ioctl(), blocking/non
+        blocking mode, interrupt handler, dispositivo, driver de caracteres.
+      :Descripción: artículo del Linux Journal Kernel Korner.
+      :Resumen: *Este artículo, el tercero de cuatro sobre escritura de
+         drivers de dispositivos de caracteres, introduce conceptos de
+         lectura, escritura y uso de llamadas ioctl*.
+
+    * Título: **Dissecting Interrupts and Browsing DMA**
+
+      :Autor: Alessandro Rubini and Georg v. Zezschwitz.
+      :URL: https://www.linuxjournal.com/article.php?sid=1222
+      :Fecha: 1996
+      :Palabras Clave: interrupciones, irqs, DMA, bottom halves, task queues.
+      :Descripción: artículo del Linux Journal Kernel Korner.
+      :Resumen: *Este es el cuarto de una serie de artículos sobre escribir
+         drivers de dispositivos de caracteres como módulos cargables del
+         kernel. Este mes, investigamos más a fondo el tema de manejo de
+         interrupciones. Aunque es conceptualmente simple, las limitaciones
+         prácticas y las restricciones hacen que esta sea una parte
+         "interesante" sobre la escritura del driver del dispositivo, y se
+         han proporcionado varias cuestiones diferentes para diferentes
+         situaciones. También investigamos el complejo tema de DMA*.
+
+    * Título: **Device Drivers Concluded**
+
+      :Autor: Georg v. Zezschwitz.
+      :URL: https://www.linuxjournal.com/article.php?sid=1287
+      :Fecha: 1996
+      :Palabras Clave: address spaces, pages, pagination, page management,
+        demand loading, swapping, memory protection, memory mapping, mmap,
+        virtual memory areas (VMAs), vremap, PCI, espacio de direcciones,
+        gestión de páginas.
+      :Descripción: Finalmente, lo anterior resultó en una serie de cinco
+         artículos. La introducción de este último dice: "Este es el último
+         de cinco artículos sobre drivers de dispositivos de caracteres. En
+         esta sección final, Georg se ocupa de los dispositivos de mapeo de
+         memoria, comenzando con una descripción general de los conceptos
+         de gestión de memoria de Linux".
+
+    * Título: **Network Buffers And Memory Management**
+
+      :Autor: Alan Cox.
+      :URL: https://www.linuxjournal.com/article.php?sid=1312
+      :Fecha: 1996
+      :Palabras Clave: sk_buffs, network devices, protocol/link layer
+        variables, network devices flags, transmit, receive,
+        configuration, multicast, redes, transmitir, recibir, drivers de red.
+      :Descripción: Linux Journal Kernel Korner.
+      :Resumen: *Escribir un driver de dispositivo de red para Linux es
+         fundamentalmente simple --- la mayor parte de la complejidad
+         (aparte de hablar con el hardware) implica la gestión de paquetes
+         de red en la memoria*.
+
+    * Título: **Analysis of the Ext2fs structure**
+
+      :Autor: Louis-Dominique Dubeau.
+      :URL: https://teaching.csse.uwa.edu.au/units/CITS2002/fs-ext2/
+      :Fecha: 1994
+      :Palabras Clave: ext2, filesystem, ext2fs, inodos.
+      :Descripción: Descripción de los bloques, directorios, inodos,
+         mapas de bits, invariantes...
+
+Libros publicados
+-----------------
+
+    * Título: **Linux Treiber entwickeln**
+
+      :Autor: Jürgen Quade, Eva-Katharina Kunst
+      :Publica: dpunkt.verlag
+      :Fecha: Oct 2015 (4th edition)
+      :Paginas: 688
+      :ISBN: 978-3-86490-288-8
+      :Note: Alemán. La tercera edición de 2011 es
+         mucho más barata y todavía (?) bastante actualizada.
+
+    * Título: **Linux Kernel Networking: Implementation and Theory**
+
+      :Autor: Rami Rosen
+      :Publica: Apress
+      :Fecha: December 22, 2013
+      :Paginas: 648
+      :ISBN: 978-1430261964
+
+    * Título: **Embedded Linux Primer: A practical Real-World Approach, 2nd Edition**
+
+      :Autor: Christopher Hallinan
+      :Publica: Pearson
+      :Fecha: November, 2010
+      :Paginas: 656
+      :ISBN: 978-0137017836
+
+    * Título: **Linux Kernel Development, 3rd Edition**
+
+      :Autor: Robert Love
+      :Publica: Addison-Wesley
+      :Fecha: July, 2010
+      :Paginas: 440
+      :ISBN: 978-0672329463
+
+    * Título: **Essential Linux Device Drivers**
+
+      :Autor: Sreekrishnan Venkateswaran
+      :Published: Prentice Hall
+      :Fecha: April, 2008
+      :Paginas: 744
+      :ISBN: 978-0132396554
+
+.. _sp_ldd3_published:
+
+    * Título: **Linux Device Drivers, 3rd Edition**
+
+      :Authors: Jonathan Corbet, Alessandro Rubini, and Greg Kroah-Hartman
+      :Publica: O'Reilly & Associates
+      :Fecha: 2005
+      :Paginas: 636
+      :ISBN: 0-596-00590-3
+      :Notas: Más información en
+        http://www.oreilly.com/catalog/linuxdrive3/
+        formato PDF, URL: https://lwn.net/Kernel/LDD3/
+
+    * Título: **Linux Kernel Internals**
+
+      :Autor: Michael Beck
+      :Publica: Addison-Wesley
+      :Fecha: 1997
+      :ISBN: 0-201-33143-8 (segunda edición)
+
+    * Título: **Programmation Linux 2.0 API systeme et fonctionnement du noyau**
+
+      :Autor: Remy Card, Eric Dumas, Franck Mevel
+      :Publica: Eyrolles
+      :Fecha: 1997
+      :Paginas: 520
+      :ISBN: 2-212-08932-5
+      :Notas: French
+
+    * Título: **The Design and Implementation of the 4.4 BSD UNIX Operating System**
+
+      :Autor: Marshall Kirk McKusick, Keith Bostic, Michael J. Karels,
+        John S. Quarterman
+      :Publica: Addison-Wesley
+      :Fecha: 1996
+      :ISBN: 0-201-54979-4
+
+    * Título: **Unix internals -- the new frontiers**
+
+      :Autor: Uresh Vahalia
+      :Publica: Prentice Hall
+      :Fecha: 1996
+      :Paginas: 600
+      :ISBN: 0-13-101908-2
+
+    * Título: **Programming for the real world - POSIX.4**
+
+      :Autor: Bill O. Gallmeister
+      :Publica: O'Reilly & Associates, Inc
+      :Fecha: 1995
+      :Paginas: 552
+      :ISBN: I-56592-074-0
+      :Notas: Aunque no se trata directamente de Linux, Linux pretende ser
+        POSIX. Buena referencia.
+
+    * Título:  **UNIX  Systems  for  Modern Architectures: Symmetric Multiprocessing and Caching for Kernel Programmers**
+
+      :Autor: Curt Schimmel
+      :Publica: Addison Wesley
+      :Fecha: June, 1994
+      :Paginas: 432
+      :ISBN: 0-201-63338-8
+
+    * Título: **The Design and Implementation of the 4.3 BSD UNIX Operating System**
+
+      :Autor: Samuel J. Leffler, Marshall Kirk McKusick, Michael J
+        Karels, John S. Quarterman
+      :Publica: Addison-Wesley
+      :Fecha: 1989 (reimpreso con correcciones en October, 1990)
+      :ISBN: 0-201-06196-1
+
+    * Título: **The Design of the UNIX Operating System**
+
+      :Autor: Maurice J. Bach
+      :Publica: Prentice Hall
+      :Fecha: 1986
+      :Paginas: 471
+      :ISBN: 0-13-201757-1
+
+Recursos varios
+---------------
+
+    * Título: **Cross-Referencing Linux**
+
+      :URL: https://elixir.bootlin.com/
+      :Palabras Clave: Browsing source code.
+      :Descripción: Otro navegador de código fuente del kernel Linux que se
+        encuentra en la web.  Muchas referencias cruzadas a variables y
+        funciones. Puedes ver dónde se definen y dónde se utilizan.
+
+    * Título: **Linux Weekly News**
+
+      :URL: https://lwn.net
+      :Palabras Clave: latest kernel news, noticias del kernel Linux.
+      :Descripción: El título lo dice todo (Noticias Semanales de Linux).
+        Hay una sección fija sobre el kernel, resumiendo el trabajo de sus
+        desarrolladores, correcciones de errores, nuevas funciones y
+        versiones, producido durante la semana. Publicado todos los jueves.
+
+    * Título: **The home page of Linux-MM**
+
+      :Autor: The Linux-MM team.
+      :URL: https://linux-mm.org/
+      :Palabras Clave: memory management, Linux-MM, mm patches, TODO, docs,
+        mailing list, administración de memoria, Linux-MM, parches mm, listas
+        de correo.
+      :Descripción: Sitio dedicado al desarrollo de la gestión de memoria
+        de Linux. Parches relacionados con la memoria, HOWTOs, enlaces,
+        desarrolladores de mm... ¡Si está interesado en el desarrollo de la
+        gestión de memoria no te lo pierdas!
+
+    * Título: **Kernel Newbies IRC Channel and Website**
+
+      :URL: https://www.kernelnewbies.org
+      :Palabras Clave: IRC, newbies, channel, asking doubts, canal, dudas,
+        novatos, preguntar.
+      :Descripción: #kernelnewbies en irc.oftc.net.
+        #kernelnewbies es una red de IRC dedicada al hacker del kernel
+        'novato'. La audiencia se compone principalmente de personas que
+        quieren aprender sobre el kernel, trabajar en proyectos del kernel
+        o hackers profesionales del kernel que quieren ayudar a la gente
+        menos experimentada.
+        #kernelnewbies es parte de la red OFTC IRC.
+        Pruebe con irc.oftc.net como su servidor y luego haga /join
+        #kernelnewbies.
+        El sitio web kernelnewbies también alberga artículos, documentos, FAQs...
+
+    * Título: **linux-kernel mailing list archives and search engines**
+
+      :URL: http://vger.kernel.org/vger-lists.html
+      :URL: http://www.uwsg.indiana.edu/hypermail/linux/kernel/index.html
+      :URL: http://groups.google.com/group/mlist.linux.kernel
+      :Palabras Clave: linux-kernel, archives, buscar, search, archivos.
+      :Descripción: Algunos de los archivadores de listas de correo del
+        kernel de Linux. Si usted tiene uno mejor/otro, por favor hágamelo
+        saber.
+
+-------
+
+Este documento se basaba originalmente en:
+
+  https://www.dit.upm.es/~jmseyas/linux/kernel/hackers-docs.html
+
+escrito por Juan-Mariano de Goyenche
-- 
2.34.1

